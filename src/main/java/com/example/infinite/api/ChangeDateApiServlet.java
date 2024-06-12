package com.example.infinite.api;

import com.example.infinite.DatabaseManager;
import com.example.infinite.ErrorCodeDictionary;
import com.example.infinite.HomeServlet;
import com.example.infinite.ai.ICModel;
import com.example.infinite.domain.Element;
import com.example.infinite.domain.Game;
import com.example.infinite.domain.User;
import com.example.infinite.dto.ChangeDateResponse;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

@WebServlet(name = "change-date-api", value = "/api/change-date")
public class ChangeDateApiServlet extends HttpServlet {
    private void sendResponse(HttpServletResponse response, ChangeDateResponse changeDateResponse) throws IOException {
        response.setHeader("Access-Control-Allow-Origin", "*"); // Allow all origins
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With, remember-me");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String jsonString = gson.toJson(changeDateResponse);
        out.println(jsonString);
    }
    public void doGet(HttpServletRequest servletRequest, HttpServletResponse response) throws IOException {
        ChangeDateResponse changeDateResponse = new ChangeDateResponse();
        try{
            int userId = Integer.parseInt(servletRequest.getParameter("userId"));
            String date = servletRequest.getParameter("date");
            changeDateResponse = handleChangeDate(userId, date);
        }
        catch (Exception e){
            changeDateResponse.setError(e.getMessage());
        }
        sendResponse(response, changeDateResponse);
    }
    public static ChangeDateResponse handleChangeDate(int userId, String date){
        ChangeDateResponse changeDateResponse = new ChangeDateResponse();
        try {
            DatabaseManager databaseManager = DatabaseManager.getInstance();
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date gameDay = dateFormat.parse(date);
            User user = new User(userId);
            //Aqui recebe os dados do jogo do dia escolhido, com a lista de elementos
            Game game = new Game(gameDay, user);
            int code = databaseManager.getGame(game);
            if(code != 0){
                throw new Exception("Could not create game");
            }
            changeDateResponse.setGame(game);
            changeDateResponse.setError("");
        }catch(Exception e) {
            changeDateResponse.setError(e.getMessage());
        }
        return changeDateResponse;
    }
    public void destroy() {
    }
}
