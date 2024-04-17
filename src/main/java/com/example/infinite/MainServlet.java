package com.example.infinite;

import java.io.*;
import com.google.gson.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class MainServlet extends HttpServlet {
    private String message;
    private DatabaseManager databaseManager;
    private String user;
    private String gameDay;

    public void init() {
        message = "SUP JIZZERS!";
        //user=="" significa que ainda não logou
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
        String username = new String();
        String password = new String();
        if(type.equals("LOGIN")){
            username = jsonObject.get("username").getAsString();
            password = jsonObject.get("password").getAsString();
            code = databaseManager.authenticateUser(username, password);
            gameDay = todayDay();
        }
        else if(type.equals("REGISTER")){
            // Register the user into the database
            username = jsonObject.get("username").getAsString();
            password = jsonObject.get("password").getAsString();
            code = databaseManager.registerUser(username, password);
            gameDay = todayDay();
        }
        else if(type.equals("CHANGEDATE")){
            String date = jsonObject.get("data").getAsString();
            if(isValidData(date)){
                gameDay= date;
                code = 0;
            }
            else{
                code = 4;
            }
        }
        if(code==0){
            if(isDone()){
                sendDoneMessage(response);
                return;
            }
            user = username;
            Array <Elemento> elements = DatabaseManager.getElementsArray(gameDay,user);
            sendElementsList(elements, response,code, ErrorCodeDictionary.getErrorMessage(code));
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
            String dad = jsonObject.get("dad").getAsString();
            String mom = jsonObject.get("mom").getAsString();
            String son = DatabaseManager.searchSon(mom,dad,gameDay);
            if(son!=null){
                sendElementSon(son, response);
            }
            else{
                //função que pega da IA
                JsonObject jsonResponse = new JsonObject();
                jsonResponse = getElementSon();
                DatabaseManager.saveSon(mom,dad,jsonResponse.get("son").toString());
                PrintWriter out = response.getWriter();
                out.println(jsonResponse.toString());
            }
        }
        else if(type.equals("END")){
            String score = jsonObject.get("score").getAsString();
            String time = jsonObject.get("time").getAsString();
            String pastGame = jsonObject.get("pastGame").getAsString();
            //se estiver salvo na tabela o isDone retornará true
            DatabaseManager.saveGameInstance(score,time,pastGame);
        }
    }

    private String todayDay(){
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(today);
    }

    private void sendElementsList(Array<Elemento> elements, HttpServletResponse response, int code, String error) {

    }

    private void sendElementSon(String son, HttpServletResponse response) {

    }

    private void sendErrorMessage(int code, String error, HttpServletResponse response) {

    }

    private void sendDoneMessage(HttpServletResponse response) {
        DatabaseManager.getGameInstanceData();
    }

    private boolean isValidData(String data){

    }

    private boolean isDone(){

    }

    private JsonObject getElementSon() {

    }

    public void destroy() {
    }
}