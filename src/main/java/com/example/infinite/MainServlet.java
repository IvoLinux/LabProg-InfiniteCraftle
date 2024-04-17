package com.example.infinite;

import java.io.*;
import com.google.gson.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import javax.xml.crypto.Data;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;
import java.util.ArrayList;


@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class MainServlet extends HttpServlet {
    private String message;
    private DatabaseManager databaseManager;
    private String user;
    private String gameDay;
    private long initialTime;

    public void init() {
        message = "SUP JIZZERS!";
        //user=="" significa que ainda não logou
        try {
            databaseManager = new DatabaseManager();
        } catch (SQLException e){
        }
        user = "";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Read JSON payload from request
        response.setContentType("application/json");
        BufferedReader reader = request.getReader();
        StringBuilder jsonPayload = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonPayload.append(line);
        }

        // Parse JSON payload
        JsonObject jsonObject = JsonParser.parseString(jsonPayload.toString()).getAsJsonObject();
        String type = jsonObject.get("type").getAsString();
        int code=-1;
        String username = "", password = "";

        if(type.equals("LOGIN")){
            username = jsonObject.get("username").getAsString();
            password = jsonObject.get("password").getAsString();
            code = databaseManager.authenticateUser(username, password);
            gameDay = todayDay();
            initialTime = System.currentTimeMillis();
        }
        else if(type.equals("REGISTER")){
            // Register the user into the database
            username = jsonObject.get("username").getAsString();
            password = jsonObject.get("password").getAsString();
            code = databaseManager.registerUser(username, password);
            gameDay = todayDay();
            initialTime = System.currentTimeMillis();
        }
        else if(type.equals("CHANGEDATE")){
            username = jsonObject.get("username").getAsString();
            String date = jsonObject.get("data").getAsString();
            if(isValidData(date)){
                gameDay = date;
                code = 0;
            }
            else{
                code = 4;
            }
        }
        if(code==0){
            if(gameDay.equals(todayDay())){
                databaseManager.updateLastGames(gameDay);
                //ArrayList<Element> elements = databaseManager.getGameInstance(gameDay, username);
            }
            //sendElementsList(elements, response,code, ErrorCodeDictionary.getErrorMessage(code));
        }
        else{
            sendErrorMessage(code,ErrorCodeDictionary.getErrorMessage(code),response);
        }
        /*
        // Set content type to JSON
        response.setContentType("application/json");

        // Send response
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("code", code);
        jsonResponse.addProperty("message", ErrorCodeDictionary.getErrorMessage(code));
        PrintWriter out = response.getWriter();
        out.println(jsonResponse.toString());
        */
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException{
        BufferedReader reader = request.getReader();
        response.setContentType("application/json");
        StringBuilder jsonPayload = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonPayload.append(line);
        }

        // Parse JSON payload
        JsonObject jsonObject = JsonParser.parseString(jsonPayload.toString()).getAsJsonObject();
        String type = jsonObject.get("type").getAsString();
        if(type.equals("CRAFT")){
            boolean craft = true;
            boolean end = false;
            String dad = jsonObject.get("dad").getAsString();
            String mom = jsonObject.get("mom").getAsString();
            //modificar para receber son e emoji
            //String son = DatabaseManager.searchSon(mom,dad,gameDay);
            //if(son==null){
                //função que pega da IA
              //  son = getElementSon();
                //DatabaseManager.saveSon(mom,dad,son.toString());
            //}

            //if(son==null){
              //  craft = false;
         //   }
            //else if(isElementDay(son)){
              //  end = true;
                long time= 0;
//                if(gameDay.equals(todayDay())){
  //                  time= (System.currentTimeMillis()- initialTime)/1000;
    //            }
                int numElements = getNumElements();
                int score = score(time,numElements);
      //          DatabaseManager.saveGameDay(time, score, user, gameDay);
            //}
        //    sendElementSon(son, emoji, response, craft, end);
        }
    }
    //OK
    private String todayDay(){
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(today);
    }

    //private void sendElementsList(Array<Element> elements, HttpServletResponse response, int code, String error) {
    //}

    private void sendElementSon(String son, HttpServletResponse response, boolean craft, boolean end) {

    }

    private void sendErrorMessage(int code, String error, HttpServletResponse response) {

    }

    private void sendDoneMessage(HttpServletResponse response) {
        //DatabaseManager.getGameInstanceData();
    }

    private boolean isValidData(String data){
        return true;
    }

    private boolean isDone(){
        return true;
    }

    private boolean isElementDay(String son){
        return true;
    }

    private String getElementSon() {
        return "";
    }

    private int getNumElements(){
        return 0;
    }
    //OK
    private int score(long time, int numElements){
        return (int)time * numElements/100000;
    }
    public void destroy() {
    }
}