package com.example.infinite.api;

import com.example.infinite.*;
import com.example.infinite.ai.ICModel;
import com.example.infinite.dto.CraftRequest;
import com.example.infinite.dto.CraftResponse;
import com.example.infinite.domain.Element;
import com.example.infinite.domain.Game;
import com.example.infinite.domain.User;
import com.google.gson.Gson;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

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
    private void sendResponse(HttpServletResponse response, CraftResponse craftResponse) throws IOException {
        response.setHeader("Access-Control-Allow-Origin", "*"); // Allow all origins
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With, remember-me");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String jsonString = gson.toJson(craftResponse);
        out.println(jsonString);
    }
    public void doPost(HttpServletRequest servletRequest, HttpServletResponse response) throws IOException {
        CraftResponse craftResponse = new CraftResponse();
        try{
            CraftRequest craftRequest = readJson(servletRequest);
            craftResponse = handleCraft(craftRequest);
            craftResponse.setError("");
        }
        catch (Exception e){
            craftResponse.setError(e.getMessage());
        }
        sendResponse(response, craftResponse);
    }
    public static CraftResponse handleCraft(CraftRequest request){
        CraftResponse craftResponse = new CraftResponse();
        Game game = null;
        Element craftedElement = null;
        String error = "";
        boolean crafted = false;
        try {
            DatabaseManager databaseManager = DatabaseManager.getInstance();
            String parent1 = request.getParent1();
            String parent2 = request.getParent2();
            int userId = request.getUserId();
            java.util.Date gameDate = request.getGameDate();
            if(gameDate == null) throw new Exception("Invalid date");
            System.out.println("retrieving game instance...");
            User user = new User(userId);
            game = new Game(gameDate, user);
            if(databaseManager.getGame(game) != 0) throw new Exception("Game not found");
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
            if(craftedElement.getName().equals(game.getTargetElement().getName())){
                System.out.println("element of the day crafted");
                if(!game.isWin()){
                    int time = (int)(System.currentTimeMillis() - game.getTimeMillis());
                    java.util.Date gameDay = game.getDate();
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                    String todayString = formatter.format(new java.util.Date());
                    String dateString = formatter.format(gameDay);
                    if(todayString.equals(dateString)){
                        int numElements = game.getElements().size();
                        int score = scoreFunction(time, numElements);
                        game.setEndGame(score, time, true);
                    }
                    else{
                        game.setEndGame(0, time, true);
                    }
                }
                System.out.println("Saving end game...");
                if(databaseManager.saveEndGame(game) != 0){
                    throw new Exception("Error saving game result");
                }
            }
            crafted = true;
        } catch(Exception e) {
            craftResponse.setError(e.getMessage());
        }
        craftResponse.setCrafted(crafted);
        craftResponse.setElement(craftedElement);
        craftResponse.setGame(game);
        return craftResponse;
    }
    private static String getApiKey(){
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
    private static int scoreFunction(long time, int numElements) {
        double calc = (double)time / 86400;
        double resDouble = ((double)1 / (calc * numElements));
        int res = (int)Math.round(resDouble);
        return res;
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
