package com.example.infinite;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;


import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.infinite.ai.ICModel;

@WebServlet(name = "home", value = "/")
public class HomeServlet extends HttpServlet {
    private Request readJson(HttpServletRequest request) throws IOException {
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader bufferedReader = null;

        try {
            bufferedReader = request.getReader();
            String line;
            while ((line = bufferedReader.readLine()) != null) {
                stringBuilder.append(line);
            }
        } catch (IOException e) {
            System.out.println("Erro ao ler o corpo da requisição: " + e);
        } finally {
            if (bufferedReader != null) {
                bufferedReader.close();
            }
        }
        Gson gson = new Gson();
        return gson.fromJson(stringBuilder.toString(), Request.class);
    }
    private void sendResponse(HttpServletResponse response, String error, Game game, Element element, boolean crafted) throws IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        Response resp = new Response(error, game, element, crafted);
        String jsonString = gson.toJson(resp);
        out.println(jsonString);
    }
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            Game game = (Game) request.getSession().getAttribute("game");
            databaseManager.updateLastGames(game.getDate());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            System.out.println("oi");
            response.sendRedirect("/login");
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Game game = null;
        Element craftedElement = null;
        String error = null;
        boolean crafted = true;

        Request biggers = readJson(request);

        String type = biggers.getType();
        if(type.equals("changeDay")) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                java.util.Date gameDay = dateFormat.parse(request.getParameter("gameDay"));
                DatabaseManager databaseManager = new DatabaseManager();
                User user = (User)request.getSession().getAttribute("user");
                //Aqui recebe os dados do jogo do dia escolhido, com a lista de elementos
                game = new Game(gameDay, user);
                int code = databaseManager.getGame(game);
                if(code != 0){
                    error = ErrorCodeDictionary.getErrorMessage(6);
                    sendResponse(response, error, game, craftedElement, crafted);
                    return;
                }
                request.getSession().setAttribute("error", null);
                request.getSession().setAttribute("game", game);
            }catch(Exception e) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            }
        }
        else if(type.equals("craft")) {
            String parent1 = biggers.getParent1();
            String parent2 = biggers.getParent2();
            game = (Game)request.getSession().getAttribute("game");
            try {
                crafted = true;
                DatabaseManager databaseManager = new DatabaseManager();
                Element dad = new Element(parent1, "");
                Element mom = new Element(parent2, "");
                craftedElement = new Element();
                int code = databaseManager.queryElement(game, mom, dad, craftedElement);
                if (code == -1) { // deu ruim
                    error = ErrorCodeDictionary.getErrorMessage(code);
                    sendResponse(response, error, game, craftedElement, crafted);
                    return;
                }
                if(code == 7){ //não foi encontrado no BD
                    String key = "";
                    ICModel icmodel = (ICModel) ICModel.builder().APIKey(key).maxTokens(15).temperature(0.5f).build("ic");

                    ArrayList<String> elements = new ArrayList<>(Arrays.asList(icmodel.getNewCraft(parent1, parent2, "", "")));

                    elements.add(icmodel.retrieveAnswer(parent1, parent2));
                    elements.add(icmodel.retrieveAnswer(parent1, parent2));
                    if(elements.get(0) == null){
                        crafted = false;
                    }
                    else {
                        craftedElement = new Element(elements.get(0), elements.get(1), 0, dad, mom);
                        //atualiza o banco de dados e o depth do craft e atualiza a tabela de jogo do dia
                        databaseManager.craftElement(game, dad, mom, craftedElement);
                    }
                }
                java.util.Date gameDay = game.getDate();
                if(crafted && craftedElement.getId() == databaseManager.getElementDay(gameDay).getId()){
                    if(gameDay.equals(new java.util.Date())){
                        int numElements = game.getElements().size();
                        int time = (int)((long)request.getSession().getAttribute("initialTime")-System.currentTimeMillis());
                        int score = (int) scoreFunciton(time, numElements);
                        game.setEndGame(score, time, true);
                        databaseManager.saveEndGame(game);
                    }
                    else{
                        game.setEndGame(0, 0, true);
                        databaseManager.saveEndGame(game);
                    }
                }
                sendResponse(response, null, game, craftedElement, crafted);
            } catch(Exception e) {
                error = ErrorCodeDictionary.getErrorMessage(6);
            }
        }
        sendResponse(response, error, game, craftedElement, crafted);
    }

    //java.util.Date
    private String today() {
        Date today = new Date();
        SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
        return format.format(today);
    }

    private int scoreFunciton(long time, int numElements) {
        // refazer
        return (int) (10000 / (time * numElements));
    }

    public void destroy() {
    }
}
class Response {
    private String error;
    private Game game;
    private Element element;
    private boolean crafted;

    public Response(String error, Game game, Element element, boolean crafted) {
        this.error = error;
        this.game = game;
        this.element = element;
        this.crafted = crafted;
    }

    // Getters and setters for error
    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    // Getters and setters for game
    public Game getGame() {
        return game;
    }

    public void setGame(Game game) {
        this.game = game;
    }

    // Getters and setters for element
    public Element getElement() {
        return element;
    }

    public void setElement(Element element) {
        this.element = element;
    }

    // Getters and setters for crafted
    public boolean isCrafted() {
        return crafted;
    }

    public void setCrafted(boolean crafted) {
        this.crafted = crafted;
    }
}
class Request {
    private String type;
    private String parent1;
    private String parent2;

    public Request(String type, String name, String xota) {
        this.type = type;
        this.parent1 = name;
        this.parent2 = xota;
    }

    public String getParent1() {
        return parent1;
    }

    public String getParent2() {
        return parent2;
    }
    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }
    public void setParent2(String parent2) {
        this.parent2 = parent2;
    }

    public void setParent1(String parent1) {
        this.parent1 = parent1;
    }
}

