package com.example.infinite.api;


import java.io.IOException;

import com.example.infinite.*;
import com.example.infinite.dto.LoginResponse;
import com.example.infinite.domain.Game;
import com.example.infinite.domain.User;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;

/**
 * Servlet implementation class LoginServlet.
 * The value attribute defines the URL pattern that the servlet will listen to.
 */
@WebServlet(name = "login-api", value = "/api/login")
public class LoginApiServlet extends HttpServlet {
    /**
     * doPost method is called when the client sends a POST request to the server
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException
     * The method checks if the username and password are correct. If they are, it forwards the request to the index.jsp file in the root folder
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LoginResponse loginResponse = handleLogin(username, password);
        response.setHeader("Access-Control-Allow-Origin", "*"); // Allow all origins
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With, remember-me");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String jsonString = gson.toJson(loginResponse);
        out.println(jsonString);
    }
    public static LoginResponse handleLogin(String username, String password){
        User user = new User(username, password);
        LoginResponse response = new LoginResponse();
        //cria User e passa por referencia pro authenticate tudo com Username vira user
        try {
            DatabaseManager databaseManager = DatabaseManager.getInstance();
            int code = databaseManager.authenticateUser(user);
            // System.out.println(code);
            if (code != 0) {
                response.setError(ErrorCodeDictionary.getErrorMessage(code));
                return response;
            } else {
                //Aqui recebe os dados do jogo de hoje, com a lista de elementos
                Game game = new Game(new java.util.Date(), user);
                System.out.println("...updating last games");
                databaseManager.updateLastGames(game.getDate());
                System.out.println("...updating game");
                int code2 = databaseManager.getGame(game);
                if (code2 != 0) {
                    response.setError(ErrorCodeDictionary.getErrorMessage(code2));
                    return response;
                }
                //Aqui recebe a lista de jogos já ganhos com os scores e tempos
                ArrayList<Date> listDates = databaseManager.getDates();
                response.setError("");
                response.setElementDay(databaseManager.getElementDay(new java.util.Date()));
                response.setInitialTime(System.currentTimeMillis());
                response.setListDates(listDates);
                response.setGame(game);
                return response;
            }
        } catch (Exception e) {
            response.setError(ErrorCodeDictionary.getErrorMessage(6));
            return response;
        }
    }
    /**
     * destroy method is called when the servlet is being destroyed
     */
    public void destroy() {
    }
}
