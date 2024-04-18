package com.example.infinite;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.infinite.ai.ICModel;

@WebServlet(name = "home", value = "/")
public class HomeServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            Game game = (Game)request.getSession().getAttribute("game");
            databaseManager.updateLastGames(game.getDate());
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }catch(Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String type = request.getParameter("type");
        if(type.equals("changeDay")) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date gameDay = dateFormat.parse(request.getParameter("gameDay"));
                DatabaseManager databaseManager = new DatabaseManager();
                User user = (User)request.getSession().getAttribute("user");
                //Aqui recebe os dados do jogo do dia escolhido, com a lista de elementos
                Game game = new Game(gameDay, user);
                int code = databaseManager.getGame(game);
                if(code != 0){
                    request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
                    response.sendRedirect("/");
                    return;
                }
                request.getSession().setAttribute("error", null);
                request.getSession().setAttribute("game", game);
            }catch(Exception e) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            }
        }
        else if(type.equals("craft")) {
            String parent1 = request.getParameter("parent1");
            String emoji1 =  request.getParameter("emoji1");
            String parent2 = request.getParameter("parent2");
            String emoji2 =  request.getParameter("emoji2");
            User user = (User) request.getSession().getAttribute("user");
            Game game = (Game)request.getSession().getAttribute("game");
            try {
                boolean crafted = true;
                DatabaseManager databaseManager = new DatabaseManager();
                Element dad = new Element(parent1, emoji1);
                Element mom = new Element(parent2, emoji2);
                Element craftedElement = new Element();
                int code = databaseManager.queryElement(game, mom, dad, craftedElement);
                if (code == -1) { // deu ruim
                    request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code));
                    response.sendRedirect("/");
                    return;
                }
                if(code == 7){ //não foi encontrado no BD
                    String key = "";
                    ICModel icmodel = (ICModel) ICModel.builder().APIKey(key).maxTokens(15).temperature(0.5f).build("ic");
                    ArrayList<String> elements = new ArrayList<>(Arrays.asList(icmodel.getNewCraft(parent1, parent2, emoji1, emoji2)));
                    elements.add(icmodel.retrieveAnswer(parent1, parent2));
                    elements.add(icmodel.retrieveAnswer(parent1, parent2));
                    if(elements.get(0) == null){
                        crafted = false;
                    }
                    else {
                        craftedElement = new Element(elements.get(0), elements.get(1), 0, dad, mom);
                        //atualiza o banco de dados e o depth do craft e atualiza a tabela de jogo do dia
                        databaseManager.craftElement(game, dad, mom, craftedElement);
                    }
                }
                java.util.Date gameDay = game.getDate();
                if(crafted && craftedElement.getId() == databaseManager.getElementDay(gameDay).getId()){
                    if(gameDay.equals(new java.util.Date())){
                        int numElements = game.getElements().size();
                        int time = (int)((long)request.getSession().getAttribute("initialTime")-System.currentTimeMillis());
                        int score = (int) scoreFunciton(time, numElements);
                        game.setEndGame(score, time, true);
                        databaseManager.saveEndGame(game);
                    }
                    else{
                        game.setEndGame(0, 0, true);
                        databaseManager.saveEndGame(game);
                    }
                }
                request.getSession().setAttribute("gameInstance",game);
                request.getSession().setAttribute("crafted", crafted);
                request.getSession().setAttribute("craft", craftedElement);
                request.getSession().setAttribute("error", null);
            } catch(Exception e) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            }
        }
        response.sendRedirect("/");
    }

    //java.util.Date
    private String today(){
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(today);
    }

    private int scoreFunciton(long time, int numElements){
        // refazer
        return (int)(10000/(time*numElements));
    }

    public void destroy() {
    }
}

