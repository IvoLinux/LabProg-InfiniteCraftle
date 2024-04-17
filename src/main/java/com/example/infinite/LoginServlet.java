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

        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            int code = databaseManager.authenticateUser(username, password);
            if (code != 0) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code));
                response.sendRedirect("/login");
            } else {
                //Aqui recebe os dados do jogo de hoje, com a lista de elementos
                GameInstance gameInstance = databaseManager.getGameInstance(today(), username);
                //Aqui recebe a lista de jogos já ganhos com os scores e tempos
                List <String> listOfGamesDones = databaseManager.listOfGamesDones(username);
                request.getSession().setAttribute("initialTime",System.currentTimeMillis());
                request.getSession().setAttribute("error", null);
                request.getSession().setAttribute("username", username);
                request.getSession().setAttribute("listOfGamesDones", listOfGamesDones);
                request.getSession().setAttribute("gameInstance", gameInstance);
                request.getSession().setAttribute("gameDay",today());
                response.sendRedirect("/login");
            }
        }catch(Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            response.sendRedirect("/login");
        }
    }

    private String today(){
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(today);
    }

    public void destroy() {
    }
}
