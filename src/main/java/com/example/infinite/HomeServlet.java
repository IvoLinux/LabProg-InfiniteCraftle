package com.example.infinite;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.infinite.ai.ICModel;



/**
 * Servlet implementation class HomeServlet. The value attribute defines the URL pattern that the servlet will listen to
 */
@WebServlet(name = "home", value = "/")
public class HomeServlet extends HttpServlet {
    private DatabaseManager databaseManager;
    /**
     * This method reads the JSON data sent from the client in a POST request.
     * It uses a StringBuilder to accumulate the JSON data line by line as it is read
     * from the request body using a BufferedReader.
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @throws IOException when an error occurs while reading the request
     */
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
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        Response resp = new Response(error, game, element, crafted);
        String jsonString = gson.toJson(resp);
        out.println(jsonString);
    }
    
    /**
     * doGet method is called when the client sends a GET request to the server.
     * This method forwards the request to the index.jsp file in the home folder.
     * It verifies if a user is logged. If he isn't, redirects to the login page.
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException when an error occurs while reading the request
     * @throws ServletException when an error occurs while forwarding the request
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Game game = (Game) request.getSession().getAttribute("game");
            if(game == null) throw new Exception("game not set");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            response.sendRedirect("/login");
        }
    }

    /**
     * doPost method is called when the client sends a POST request to the server.
     * This method reads the request from the client and processes it.
     * It can change the day of the game or craft a new element.
     * This method processes incoming POST requests, determining the action to take based on the request type.
     * For "changeDay" requests, it retrieves game data for the specified day and user from the database.
     * For "craft" requests, it processes the crafting of a new element based on two parent elements.
     * After processing, it sends a response back to the client.
     * @param servletRequest HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException
     */
    public void doPost(HttpServletRequest servletRequest, HttpServletResponse response) throws IOException {
        Game game = null;
        Element craftedElement = null;
        String error = "";
        boolean crafted = true;

        Request request = readJson(servletRequest);

        String type = request.getType();
        if(type.equals("changeDay")) {
            error = handleChangeDay(servletRequest, game, error);
            sendResponse(response, error, game, craftedElement, crafted);
        }
        else if(type.equals("craft")) {
            try {
                String parent1 = request.getParent1();
                String parent2 = request.getParent2();
                System.out.println("getting game from session...");
                game = (Game)servletRequest.getSession().getAttribute("game");
                crafted = true;
                DatabaseManager databaseManager = DatabaseManager.getInstance();
                Element dad = new Element(parent1, "");
                Element mom = new Element(parent2, "");
                craftedElement = new Element();
                System.out.println("querying element...");
                int code = databaseManager.queryElement(game, mom, dad, craftedElement);
                if (code == -1) { // deu ruim
                    System.out.println("error querying");
                    error = ErrorCodeDictionary.getErrorMessage(code);
                    sendResponse(response, error, game, craftedElement, crafted);
                    return;
                }
                if(code == 7){ //não foi encontrado no BD
                    System.out.println("recipe not in db");

                    String key = getApiKey();
                    System.out.println("building model...");
                    ICModel icmodel = (ICModel) ICModel.builder().APIKey(key).maxTokens(15).temperature(0.5f).build("ic");
                    System.out.println("prompting model...");
                    ArrayList<String> elements = new ArrayList<>(Arrays.asList(icmodel.getNewCraft(parent1, parent2, "", "")));
                    //ArrayList<String> elements = new ArrayList<>();
                    //elements.add(generateRandomWord());
                    //elements.add(generateRandomEmoji());
                    if(elements.get(0) == null){
                        crafted = false;
                        System.out.println("none");
                    }
                    else {
                        System.out.println(elements.get(0));
                        System.out.println(elements.get(1));
                        craftedElement = new Element(elements.get(1), elements.get(0), 0, dad, mom);
                        //atualiza o banco de dados e o depth do craft e atualiza a tabela de jogo do dia
                        System.out.println("crafting element...");
                        databaseManager.craftElement(game, dad, mom, craftedElement);
                    }
                }
                java.util.Date gameDay = game.getDate();
                if(crafted && craftedElement.getId() == databaseManager.getElementDay(gameDay).getId()){
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
                    databaseManager.saveEndGame(game);
                }
                sendResponse(response, null, game, craftedElement, crafted);
                return;
            } catch(Exception e) {
                e.printStackTrace();
                error = ErrorCodeDictionary.getErrorMessage(6);
            }
        }
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

    public void destroy() {
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
}

/**
 * Response class is used to send the response to the client.
 * It contains the error message, the game, the element and a boolean that indicates if the element was crafted.
 * The error message is used to inform the client if an error occurred.
 * The game is used to update the game in the session.
 * The element is used to inform the client the element crafted.
 * The boolean is used to inform the client if the element was crafted.
 */
class Response {
    private String error;
    private Game game;
    private Element element;
    private boolean crafted;

    /**
     * Constructor for Response class
     * @param error error message
     * @param game game object
     * @param element element object
     * @param crafted boolean that indicates if the element was crafted
     */
    public Response(String error, Game game, Element element, boolean crafted) {
        this.error = error;
        this.game = game;
        this.element = element;
        this.crafted = crafted;
    }

    /**
     * Getter for error message
     * @return error message
     */
    public String getError() {
        return error;
    }

    /**
     * Setter for error message
     * @param error error message
     */
    public void setError(String error) {
        this.error = error;
    }

    /**
     * Getter for game
     * @return game object
     */
    public Game getGame() {
        return game;
    }

    /**
     * Setter for game
     * @param game game object
     */
    public void setGame(Game game) {
        this.game = game;
    }

    /**
     * Getter for element
     * @return element object
     */
    public Element getElement() {
        return element;
    }

    /**
     * Setter for element
     * @param element element object
     */
    public void setElement(Element element) {
        this.element = element;
    }

    /**
     * Getter for crafted
     * @return boolean that indicates if the element was crafted
     */
    public boolean isCrafted() {
        return crafted;
    }

    /**
     * Setter for crafted
     * @param crafted boolean that indicates if the element was crafted
     */
    public void setCrafted(boolean crafted) {
        this.crafted = crafted;
    }
}

/**
 * Request class is used to read the request from the client.
 * It contains the type of the request, the parent1 and the parent2.
 * The type is used to identify the type of the request.
 * The parent1 is used to identify the first parent, and parent2, the second parent.
 */
class Request {
    private String type;
    private String parent1;
    private String parent2;

    /**
     * Constructor for Request class
     * @param type type of the request
     * @param name first parent
     * @param xota second parent
     */
    public Request(String type, String name, String xota) {
        this.type = type;
        this.parent1 = name;
        this.parent2 = xota;
    }

    /**
     * Getter for parent1
     * @return parent1
     */
    public String getParent1() {
        return parent1;
    }

    /**
     * Getter for parent2
     * @return parent2
     */
    public String getParent2() {
        return parent2;
    }

    /**
     * Getter for type
     * @return type
     */
    public String getType() {
        return type;
    }

    /**
     * Setter for type
     * @param type type
     */
    public void setType(String type) {
        this.type = type;
    }

    /**
     * Setter for parent2
     * @param parent2 parent2
     */
    public void setParent2(String parent2) {
        this.parent2 = parent2;
    }

    /**
     * Setter for parent1
     * @param parent1 parent1
     */
    public void setParent1(String parent1) {
        this.parent1 = parent1;
    }
}

