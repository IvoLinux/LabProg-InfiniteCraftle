package com.example.infinite;


import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;


@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/login/index.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User(username, password);
        //cria User e passa por referencia pro authenticate tudo com Username vira user
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            int code = databaseManager.authenticateUser(user);
            System.out.println(code);
            if (code != 0) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code));
                response.sendRedirect("/login");
                return;
            } else {
                //Aqui recebe os dados do jogo de hoje, com a lista de elementos
                Game game = new Game(new java.util.Date(), user);
                int code2 = databaseManager.getGame(game);
                if (code2 != 0) {
                    request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code2));
                    response.sendRedirect("/login");
                    return;
                }
                //Aqui recebe a lista de jogos já ganhos com os scores e tempos
                List<java.util.Date> listDates = databaseManager.getDates();
                request.getSession().setAttribute("elementDay", databaseManager.getElementDay(new java.util.Date()));
                request.getSession().setAttribute("initialTime", System.currentTimeMillis());
                request.getSession().setAttribute("error", null);
                request.getSession().setAttribute("user", user);
                request.getSession().setAttribute("listDates", listDates);
                request.getSession().setAttribute("game", game);
                response.sendRedirect("/");
                return;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }
        response.sendRedirect("/login");
    }

    public void destroy() {
    }
}
