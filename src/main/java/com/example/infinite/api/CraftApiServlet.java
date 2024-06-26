package com.example.infinite.api;

import com.example.infinite.*;
import com.example.infinite.ai.ICModel;
import com.example.infinite.dto.CraftRequest;
import com.example.infinite.dto.CraftResponse;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

@WebServlet(name = "craft-api", value = "/api/craft")
public class CraftApiServlet extends HttpServlet {
    /**
     * This method reads the JSON data sent from the client in a POST request.
     * It uses a StringBuilder to accumulate the JSON data line by line as it is read
     * from the request body using a BufferedReader.
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @throws IOException when an error occurs while reading the request
     */
    private CraftRequest readJson(HttpServletRequest request) throws Exception {
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            bufferedReader = request.getReader();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch (IOException e) {
            throw new Exception("Erro ao ler o corpo da requisição: " + e);
        } finally {
            if (bufferedReader != null) {
                bufferedReader.close();
            }
        }
        Gson gson = new Gson();
        return gson.fromJson(stringBuilder.toString(), CraftRequest.class);
    }
    /**
     * sendResponse method is used to send the response to the client.
     * It sends the error message, the game, the element and a boolean that indicates if the element was crafted.
     * The error message is used to inform the client if an error occurred.
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @param error error message
     * @param game game object
     * @param element element object
     * @param crafted boolean that indicates if the element was crafted
     * @throws IOException when an error occurs while sending the response
     */
    private void sendResponse(HttpServletResponse response, String error, Game game, Element element, boolean crafted) throws IOException {
        response.setHeader("Access-Control-Allow-Origin", "*"); // Allow all origins
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With, remember-me");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        CraftResponse resp = new CraftResponse(error, game, element, crafted);
        String jsonString = gson.toJson(resp);
        out.println(jsonString);
    }
    public void doPost(HttpServletRequest servletRequest, HttpServletResponse response) throws IOException {
        Game game = null;
        Element craftedElement = null;
        String error = "";
        boolean crafted = false;
        try {
            CraftRequest request = readJson(servletRequest);
            DatabaseManager databaseManager = DatabaseManager.getInstance();
            String parent1 = request.getParent1();
            String parent2 = request.getParent2();
            int userId = request.getUserId();
            java.util.Date gameDate = request.getGameDate();
            if(gameDate == null) throw new Exception("Invalid date");
            System.out.println("getting game from session...");

            //game = (Game)servletRequest.getSession().getAttribute("game");
            User user = new User(userId);
            game = new Game(gameDate, user);
            databaseManager.getGame(game);
            if(databaseManager.getGame(game) == -1){
                throw new Exception("Could not retrieve game");
            }
            Element dad = new Element(parent1, "");
            Element mom = new Element(parent2, "");
            craftedElement = new Element();
            System.out.println("querying element...");
            int code = databaseManager.queryElement(game, mom, dad, craftedElement);
            if(code == -1){
                throw new Exception("Error while querying element");
            }
            if(code == 7){ //não foi encontrado no BD
                System.out.println("recipe not in db");
                String key = getApiKey();
                System.out.println("building model...");
                ICModel icmodel = (ICModel) ICModel.builder().APIKey(key).maxTokens(15).temperature(0.5f).build("ic");
                System.out.println("prompting model...");
                ArrayList<String> elements = new ArrayList<>(Arrays.asList(icmodel.getNewCraft(parent1, parent2, "", "")));
                if(elements.get(0) == null){
                    throw new Exception("Error getting AI element");
                }
                System.out.println(elements.get(0));
                System.out.println(elements.get(1));
                craftedElement = new Element(elements.get(1), elements.get(0), 0, dad, mom);
                //atualiza o banco de dados e o depth do craft e atualiza a tabela de jogo do dia
                System.out.println("crafting element...");
                if(databaseManager.craftElement(game, dad, mom, craftedElement) == -1){
                    throw new Exception("Error crafting new element");
                }
            }
            java.util.Date gameDay = game.getDate();
            Element elementDay = databaseManager.getElementDay(gameDay);
            if(craftedElement.getName().equals(elementDay.getName())){
                System.out.println("element of the day crafted");
                if(gameDay.equals(new java.util.Date())){
                    int numElements = game.getElements().size();
                    int time = (int)((long)servletRequest.getSession().getAttribute("initialTime")-System.currentTimeMillis());
                    int score = (int) scoreFunction(time, numElements);
                    game.setEndGame(score, time, true);
                }
                else{
                    game.setEndGame(0, 0, true);
                }
                System.out.println("Saving end game...");
                if(databaseManager.saveEndGame(game) == -1){
                    throw new Exception("Error saving game result");
                }
            }
            crafted = true;
        } catch(Exception e) {
            error = e.getMessage();
        }
        sendResponse(response, error, game, craftedElement, crafted);
    }
    private String getApiKey(){
        String str = "";
        String filePath = "apikey.txt";
        String absolutePath = HomeServlet.class.getClassLoader().getResource(filePath).getFile();
        File file = new File(absolutePath);
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line = br.readLine(); // Read the first line
            if (line != null) {
                str = line;
            } else {
                System.out.println("File is empty.");
            }
        } catch (IOException e) {
            System.err.println("Error reading the file: " + e.getMessage());
        }
        return str;
    }
    /**
     * scoreFunction method is used to calculate the score of the game.
     * The score is calculated based on the time and the number of elements crafted
     * @param time time taken to craft the elements
     * @param numElements number of elements crafted
     * @return the score of the game
     */
    private int scoreFunction(long time, int numElements) {
        return (int) (10000 / (time * numElements));
    }
    private String handleChangeDay(HttpServletRequest servletRequest, Game game, String error){
        try {
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date gameDay = dateFormat.parse(servletRequest.getParameter("gameDay"));
            DatabaseManager databaseManager = DatabaseManager.getInstance();
            User user = (User)servletRequest.getSession().getAttribute("user");
            //Aqui recebe os dados do jogo do dia escolhido, com a lista de elementos
            game = new Game(gameDay, user);
            int code = databaseManager.getGame(game);
            if(code != 0){
                return ErrorCodeDictionary.getErrorMessage(6);
            }
            servletRequest.getSession().setAttribute("error", "");
            servletRequest.getSession().setAttribute("game", game);
        }catch(Exception e) {
            servletRequest.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }
        return error;
    }
    public void destroy() {
    }
}
