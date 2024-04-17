package com.example.infinite;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "home", value = "/")
public class HomeServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            databaseManager.updateLastGame(request.getSession().getAttribute("gameDay"));
            request.getRequestDispatcher("/home.jsp").forward(request, response);
        }catch(Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }

    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String type = request.getParameter("type");
        if(type.equals("changeDay")) {
            String gameDay = request.getParameter("gameDay");
            try {
                DatabaseManager databaseManager = new DatabaseManager();
                //Aqui recebe os dados do jogo do dia escolhido, com a lista de elementos
                GameInstance gameInstance = databaseManager.getGame(gameDay, request.getSession().getAttribute("username"));

                request.getSession().setAttribute("error", null);
                request.getSession().setAttribute("gameInstance", gameInstance);
                request.getSession().setAttribute("gameDay",gameDay);
            }catch(Exception e) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            }
        }
        else if(type.equals("craft")) {
            String parent1 = request.getParameter("parent1");
            String emoji1 =  request.getParameter("emoji1");
            String parent2 = request.getParameter("parent2");
            String emoji2 =  request.getParameter("emoji2");
            String username = (String) request.getSession().getAttribute("username");
            String gameDay = (String) request.getSession().getAttribute("gameDay");
            try {
                boolean crafted = true;
                DatabaseManager databaseManager = new DatabaseManager();
                Element dad = new Element(parent1,emoji1);
                Element mom = new Element(parent2,emoji2);
                GameInstance game = databaseManager.getGame(username, gameDay);
                Element craft = new Element();
                int code = databaseManager.queryElement(game, mom, dad, craft);
                if (code == -1) { // deu ruim
                    request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code));
                    response.sendRedirect("/");
                    return;
                }
                if(code ==6){ //não foi encontrado no BD
                    List<String> element = getNewCraft(parent1, parent2, emoji1, emoji2);
                    if(element == null){
                        crafted = false;
                    }
                    else {
                        craft = new Element(element.get(0), element.get(1), 0, dad, mom);
                        //atualiza o banco de dados e o depth do craft e atualiza a tabela de jogo do dia
                        databaseManager.craftElement(game, dad, mom, craft);
                    }
                }
                if(craft.getId() == databaseManager.getElementDay(gameDay).getId()){
                    if(gameDay.equals(today())){
                        int numElements = game.getElements().size();
                        long time = (long)request.getSession().getAttribute("initialTime")-System.currentTimeMillis();
                        double score = scoreFunciton(time, numElements);
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
                request.getSession().setAttribute("craft", craft);
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

    private double scoreFunciton(long time, int numElements){
        return (double)10000/(time*numElements);
    }

    public void destroy() {
    }
}

