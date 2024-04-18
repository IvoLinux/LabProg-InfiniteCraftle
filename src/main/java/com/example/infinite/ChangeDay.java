package com.example.infinite;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "changeDay", value = "/changeDay")
public class ChangeDay extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String gameDay = request.getParameter("gameDay");
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            //Aqui recebe os dados do jogo do dia escolhido, com a lista de elementos
            GameInstance gameInstance = databaseManager.getGameInstance(gameDay, request.getSession().getAttribute("username"));

            request.getSession().setAttribute("error", null);
            request.getSession().setAttribute("gameInstance", gameInstance);
            request.getSession().setAttribute("gameDay",gameDay);
            response.sendRedirect("/changeDay");
            } catch (SQLException e) {
            throw new RuntimeException(e);
        } catch(Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            response.sendRedirect("/changeDay");
        }
    }

    public void destroy() {
    }
}

