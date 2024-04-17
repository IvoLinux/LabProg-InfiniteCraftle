package com.example.infinite;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

@WebServlet(name = "craft", value = "/craft")
public class CraftServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String parent1 = request.getParameter("parent1");
        String emoji1 =  request.getParameter("emoji1");
        String parent2 = request.getParameter("parent2");
        String emoji2 =  request.getParameter("emoji2");
        String username = (String) request.getSession().getAttribute("username");
        String gameDay = (String) request.getSession().getAttribute("gameDay");
        try {
            boolean generate = true;
            DatabaseManager databaseManager = new DatabaseManager();
            Element dad = databaseManager.getElement(parent1);
            Element mom = databaseManager.getElement(parent2);
            GameInstance game = databaseManager.getGame(username, gameDay);
            Element craft = new Element();
            int code = databaseManager.queryElement(mom, dad, craft, game);
            if (code !=0) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code));
                response.sendRedirect("/craft");
                return;
            }
            //Se o filho não estiver cadastrado no BD pega pela API do gpt
            if(craft == null){
                List <String> element = getNewCraft(parent1, parent2, emoji1, emoji2);
                if(element == null){
                    generate = false;
                }
                else {
                    craft = new Element(element.get(0), element.get(1), 0, dad, mom);
                    //atualiza o banco de dados e o depth do craft e atualiza a tabela de jogo do dia
                    databaseManager.craftElement(dad, mom, craft, game);
                }
            }
            if(craft == databaseManager.getElementDay(gameDay)){
                if(gameDay==today()){
                    int numElements = databaseManager.getNumElements(username,gameDay);
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
            request.getSession().setAttribute("generate", generate);
            request.getSession().setAttribute("craft", craft);
            request.getSession().setAttribute("error", null);
        } catch(Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }
        response.sendRedirect("/craft");
    }

    private String today(){
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(today);
    }

    private double scoreFunciton(long time, int numElements){
        return ((double)time*numElements)/10000;
    }

    public void destroy() {
    }
}
