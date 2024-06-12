package com.example.infinite;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.example.infinite.domain.Element;
import com.example.infinite.domain.Game;
import com.example.infinite.domain.User;
import org.mindrot.jbcrypt.*;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;


/**
 * DatabaseManager class that manages the database connection and operations, including user registration, authentication, and game data storage
 */
public class DatabaseManager {
    private static DatabaseManager instance;
    private static final String JDBC_URL = "jdbc:mysql://172.15.1.60:3306/infinitecraftledb";
    private static final String JDBC_USER = "infinitecraftle";
    private static final String JDBC_PASSWORD = "ebert";
    private static final int INITIAL_POOL_SIZE = 20;
    private List<Connection> pool;

    public static synchronized DatabaseManager getInstance() throws Exception{
        if (instance != null) {
            return instance;
        }
        synchronized (DatabaseManager.class) {
            if (instance == null) {
                try{
                    instance = new DatabaseManager();
                } catch (SQLException e){
                    throw new Exception("Could not connect to Database");
                }
            }
        }
        return instance;
    }

    // OK
    /**
     * Initializes the connection pool
     *
     */
    private void initializePool() throws SQLException {
        for (int i = 0; i < INITIAL_POOL_SIZE; i++) {
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            pool.add(connection);
        }
    }
    
    // OK
    /**
     * Gets a connection from the pool
     * @return Connection object
     */
    private synchronized Connection getConnection() throws SQLException {
        if (pool.isEmpty()) {
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        }
        return pool.remove(pool.size() - 1);
    }
    
    // OK
    /**
     * Releases a connection back to the pool
     * @param connection Connection object
     */
    private synchronized void releaseConnection(Connection connection) {
        pool.add(connection);
    }
    
    // OK
    /**
     * Loads an element from the database
     * @param element Element object
     * @return 0 if the element was loaded successfully, -1 otherwise
     */
    private int loadElement(Element element) {
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT element_id, depth, emoji \n" +
                    "FROM Element \n" +
                    "WHERE name = ? \n" +
                    "ORDER BY depth DESC \n" +
                    "LIMIT 1\n";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, element.getName());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        element.setId(resultSet.getInt("element_id"));
                        element.setDepth(resultSet.getInt("depth"));
                        element.setEmoji(resultSet.getString("emoji"));
                        return 0;
                    }
                    else{
                        return -1;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        } finally {
            if (connection != null) {
                releaseConnection(connection);
            }
        }
    }

    /**
     * Retrieves a random element from the database
     * @return Element object
     */
    private Element generateElement(){
        Connection connection = null;
        ArrayList<Element> elements = new ArrayList<>();
        Element el = new Element("","");
        try {
            connection = getConnection();
            String query = "SELECT DISTINCT element_id, name, emoji FROM Element";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        int id = resultSet.getInt("element_id");
                        String name = resultSet.getString("name");
                        String emoji = resultSet.getString("emoji");
                        el = new Element(name, emoji);
                        el.setId(id);
                        elements.add(el);
                    }
                    int randomIndex = (int) (Math.random() * elements.size());
                    return elements.get(randomIndex);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return el;
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }

    /**
     * Creates a new date in the database
     * @param date Date object
     */
    private void createDate(java.sql.Date date){
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "INSERT INTO LastGames(date, element_id) VALUES (?, ?);";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setDate(1, date);
                statement.setInt(2, generateElement().getId());
                statement.execute();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }

    // OK    
    /**
     * Stores a crafted element in the database
     * @param game Game object
     * @param element Element object
     * @return 0 if the element was stored successfully, -1 otherwise
     */
    private int storeCraftedElement(Game game, Element element){
        System.out.println("storing "+element.getName());
        String query = "INSERT INTO CraftedInGame (date, user_id, element_id)\n" +
                "SELECT ?, ?, ?\n" +
                "WHERE NOT EXISTS (\n" +
                "    SELECT 1\n" +
                "    FROM CraftedInGame\n" +
                "    WHERE date = ? AND user_id = ? AND element_id = ?\n" +
                ");\n";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setDate(1, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(2, game.getUser().getId());
                statement.setInt(3, element.getId());
                statement.setDate(4, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(5, game.getUser().getId());
                statement.setInt(6, element.getId());
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    ArrayList<Element> list = game.getElements();
                    list.add(element);
                    game.setElements(list);
                    return 0;
                } else{
                    return -1;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Error occurred during database operation
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Creates a new game in the database
     * @param game Game object
     * @return 0 if the game was created successfully, -1 otherwise
     */
    private int createGame(Game game){
        String query = "INSERT INTO GameInstance(date, user_id, score, time, win) VALUES (?,?,?,?,?)";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setDate(1, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(2, game.getUser().getId());
                statement.setInt(3, game.getScore());
                statement.setLong(4, game.getTimeMillis());
                statement.setBoolean(5, game.isWin());
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    Element e1 = new Element("Water", "");
                    Element e2 = new Element("Fire", "");
                    Element e3 = new Element("Wind", "");
                    Element e4 = new Element("Earth", "");
                    loadElement(e1);
                    loadElement(e2);
                    loadElement(e3);
                    loadElement(e4);
                    // adicionar elementos padrao
                    return storeCraftedElement(game, e1) &
                            storeCraftedElement(game, e2) &
                            storeCraftedElement(game, e3) &
                            storeCraftedElement(game, e4);
                } else{
                    return -1;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Error occurred during database operation
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Gets a list of elements from the database
     * @param game Game object
     * @return ArrayList of Element objects
     */
    private ArrayList<Element> getElementList(Game game){
        ArrayList<Element> elements = new ArrayList<>();
        String query = "SELECT e.element_id, e.name, e.emoji \n" +
                "FROM Element e \n" +
                "JOIN CraftedInGame cig ON e.element_id = cig.element_id \n" +
                "WHERE cig.date = ? AND cig.user_id = ?;";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setDate(1, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(2, game.getUser().getId());
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        String name = resultSet.getString("name");
                        String emoji = resultSet.getString("emoji");
                        Element el = new Element(name, emoji);
                        elements.add(el);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
        return elements;
    }
    
    // OK
    /**
     * DatabaseManager constructor
     * Initializes the connection pool
     * @throws SQLException when any SQL errors occur
     */
    private DatabaseManager() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(Exception e){}
        pool = new ArrayList<>();
        initializePool();
    }
    
    // OK
    /**
     * Removes a user from the database
     * @param user User object
     * @return 0 if the user was registered successfully, 1 if the username already exists, -1 otherwise
     * 
     */
    public int removeUser(User user) {
        Connection connection = null;
        try {
            connection = getConnection();
            String queryDelete = "DELETE FROM User WHERE username = ?";
            PreparedStatement statementDelete = connection.prepareStatement(queryDelete);
            statementDelete.setString(1, user.getUsername());
            statementDelete.executeUpdate();
            return 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        finally {
            if(connection != null) releaseConnection(connection);
        }
    }
    
    // OK
    /**
     * Registers a user in the database
     * @param user User object
     * @return 0 if the user was registered successfully, 1 if the username already exists, -1 otherwise
     */
    public int registerUser(User user) {
        Connection connection = null;
        try {
            connection = getConnection();
            // Check if the username already exists
            String queryCheck = "SELECT user_id FROM User WHERE username = ?";
            try (PreparedStatement statementCheck = connection.prepareStatement(queryCheck)) {
                statementCheck.setString(1, user.getUsername());
                try (ResultSet resultSet = statementCheck.executeQuery()) {
                    if (resultSet.next() && resultSet.getInt(1) > 0) {
                        user.setId(resultSet.getInt("user_id"));
                        return 1; // Username already exists
                    }
                }
            }

            // If the username doesn't exist, register the user
            String salt = BCrypt.gensalt(); // Generate a salt
            String hashedPassword = BCrypt.hashpw(user.getPassword(), salt); // Hash the password with the salt
            String queryInsert = "INSERT INTO User (username, password_hash) VALUES (?, ?)";
            try (PreparedStatement statementInsert = connection.prepareStatement(queryInsert, PreparedStatement.RETURN_GENERATED_KEYS)) {
                statementInsert.setString(1, user.getUsername());
                statementInsert.setString(2, hashedPassword);
                int rowsAffected = statementInsert.executeUpdate();
                if (rowsAffected > 0) {
                    ResultSet generatedKeys = statementInsert.getGeneratedKeys();
                    if (generatedKeys.next()) {
                        user.setId(generatedKeys.getInt(1));
                        return 0;
                    } else {
                        return -1; // Failed to retrieve user_id
                    }
                } else{
                    return -1;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        finally {
            if(connection != null) releaseConnection(connection);
        }
    }
    
    // OK
    /**
     * Authenticates a user in the database
     * @param user User object
     * @return 0 if the user was authenticated successfully, 2 if the password is incorrect, 3 if the username doesn't exist, -1 otherwise
     */
    public int authenticateUser(User user) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            String query = "SELECT * FROM User WHERE username = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, user.getUsername());
            resultSet = statement.executeQuery();
            if (resultSet.next()) {
                String storedPasswordHash = resultSet.getString("password_hash");
                user.setId(resultSet.getInt("user_id"));
                if (BCrypt.checkpw(user.getPassword(), storedPasswordHash)) {
                    return 0;
                } else {
                    return 2;
                }
            }
            else{
                return 3;
            }
        }
        catch(SQLException e){
            e.printStackTrace();
            return -1;
        }
        finally {
            if(connection != null) releaseConnection(connection);
        }
    }
    
    // OK
    /**
     * Adds an element to the database
     * @param element Element object
     * @return 0 if the element was added successfully, -1 otherwise
     */
    public int addElement(Element element){
        Connection connection = null;
        try {
            connection = getConnection();
            String queryInsert = "INSERT INTO Element (name, emoji, depth) " +
                "SELECT ?, ?, ? " +
                "WHERE NOT EXISTS ( " +
                "    SELECT 1 " +
                "    FROM Element " +
                "    WHERE name = ? " +
                ")";
            try (PreparedStatement statementInsert = connection.prepareStatement(queryInsert)) {
                statementInsert.setString(1, element.getName());
                statementInsert.setString(2, element.getEmoji());
                statementInsert.setInt(3, element.getDepth());
                statementInsert.setString(4, element.getName());
                statementInsert.setString(5, element.getEmoji());
                int rowsAffected = statementInsert.executeUpdate();
                if (rowsAffected > 0) {
                    return 0; // Element added successfully
                } else {
                    return -1; // Failed to add element
                }
            }
        } catch (SQLException e) {
            //e.printStackTrace();
            return -1; // Error occurred
        } finally {
            if (connection != null) {
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Removes an element from the database
     * @param element Element object
     * @return 0 if the element was removed successfully, -1 if the element_id was not found, -2 otherwise
     */
    public int removeElement(Element element) {
        Connection connection = null;
        try {
            connection = getConnection();
            String queryDelete = "DELETE FROM Element WHERE name = ?";
            try (PreparedStatement statementDelete = connection.prepareStatement(queryDelete)) {
                statementDelete.setString(1, element.getName());
                int rowsAffected = statementDelete.executeUpdate();
                if (rowsAffected > 0) {
                    return 0; // Element removed successfully
                } else {
                    return -1; // Failed to remove element (element_id not found)
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Error occurred
        } finally {
            if (connection != null) {
                releaseConnection(connection);
            }
        }
    }
    // OK
    /**
     * Inserts a new element in the database
     * @param game Game object
     * @param element Element object
     * @param parent1 first parent Element
     * @param parent2 second parent Element
     * @return 0 if the element was found successfully, -1 if the element_id was not found, -2 otherwise
     */
    public int craftElement(Game game, Element parent1, Element parent2, Element element){
        // Load id and depth of both parents
        loadElement(parent1);
        loadElement(parent2);
        // Set new depth of element
        element.setDepth(1 + Math.max(parent1.getDepth(), parent2.getDepth()));
        // Save new element on Element table
        addElement(element);
        // Set parents of new element
        element.setParent1(parent1);
        element.setParent2(parent2);
        // Load id of new element
        loadElement(element);
        // Insert into ElementsCrafted table
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "INSERT INTO ElementsCrafted (parent1_id, parent2_id, child_id) VALUES (?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, parent1.getId());
                statement.setInt(2, parent2.getId());
                statement.setInt(3, element.getId());
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    storeCraftedElement(game, element);
                    return 0;
                } else{
                    return -1;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Error occurred during database operation
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Queries an element from the database
     * @param game Game object
     * @param parent1 first parent Element
     * @param parent2 second parent Element
     * @param element Element object
     * @return 0 if the element was found successfully, -1 if the element_id was not found, -2 otherwise
     */
    public int queryElement(Game game, Element parent1, Element parent2, Element element){
        loadElement(parent1);
        loadElement(parent2);
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT e.element_id, e.name, e.emoji " +
                    "FROM Element e " +
                    "JOIN ElementsCrafted ec ON e.element_id = ec.child_id " +
                    "JOIN Element p1 ON ec.parent1_id = p1.element_id " +
                    "JOIN Element p2 ON ec.parent2_id = p2.element_id " +
                    "WHERE (p1.name = ? AND p2.name = ?) OR (p1.name = ? AND p2.name = ?) " +
                    "ORDER BY e.depth DESC";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, parent1.getName());
                statement.setString(2, parent2.getName());
                statement.setString(3, parent2.getName());
                statement.setString(4, parent1.getName());

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        element.setId(resultSet.getInt("element_id"));
                        element.setName(resultSet.getString("name"));
                        element.setEmoji(resultSet.getString("emoji"));
                        storeCraftedElement(game, element);
                        return 0;
                    }
                    else{
                        return 7;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Error occurred during database operation
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Updates the games played by the user
     * @param gameDay Date object
     */
    public void updateLastGames(java.util.Date gameDay){
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT MAX(date) AS most_recent_date FROM LastGames";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        java.sql.Date date = resultSet.getDate("most_recent_date");
                        if (date == null){
                            createDate(new java.sql.Date(gameDay.getTime()));
                            return;
                        }
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        LocalDate currentDate = LocalDate.parse(date.toString(), formatter);
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Define your desired pattern
                        String dateString = sdf.format(gameDay);
                        while(!date.toString().equals(dateString)){
                            currentDate = currentDate.plusDays(1);
                            date = java.sql.Date.valueOf(currentDate);
                            createDate(date);
                        }
                    }
                    else {
                        createDate(new java.sql.Date(gameDay.getTime()));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Gets the game from the database, based on the Game object
     * @param game Game object
     * @return integer code status
     */
    public int getGame(Game game){
        String query = "SELECT score, time, win FROM GameInstance WHERE date = ? AND user_id = ?";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setDate(1, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(2, game.getUser().getId());

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        game.setScore(resultSet.getInt("score"));
                        game.setTimeMillis(resultSet.getInt("time"));
                        game.setWin(resultSet.getBoolean("win"));
                        game.setElements(getElementList(game));
                        game.setTargetElement(getElementDay(game.getDate()));
                        return 0;
                    }
                    else{
                        return createGame(game);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1; // Error occurred during database operation
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
    
    // OK
    /**
     * Gets the element of the day from the database
     * @param date Date object
     * @return Element object
     */
    public Element getElementDay(java.util.Date date){
        Element el = new Element("", "");
        java.sql.Date sqlDate = new java.sql.Date(date.getTime());
        String query = "SELECT e.element_id, name, emoji FROM Element e " +
                "JOIN LastGames lg " +
                "ON e.element_id = lg.element_id " +
                "WHERE date = ?";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setDate(1, sqlDate);

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        el.setId(resultSet.getInt("element_id"));
                        el.setName(resultSet.getString("name"));
                        el.setEmoji(resultSet.getString("emoji"));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
        System.out.println("Element of day: " + el.getName());
        return el;
    }
    
    // OK
    /**
     * Gets the dates registered in the database
     * @return List of dates
     */
    public ArrayList<java.util.Date> getDates() {
        ArrayList<java.util.Date> dates = new ArrayList<>();
        String query = "SELECT date FROM LastGames";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    while (resultSet.next()) {
                        dates.add(new java.util.Date(resultSet.getDate("date").getTime()));
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
        return dates;
    }
    
    // OK
    /**
     * Saves the game played by the user
     * @param game Game object
     */
    public int saveEndGame(Game game){
        // update score and time
        int score = game.getScore();
        int time = game.getTimeMillis();
        String query = "UPDATE GameInstance\n" +
                "SET score = ?, time = ?\n" +
                "WHERE date = ? AND user_id = ?;\n";
        Connection connection = null;
        try {
            connection = getConnection();
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, score);
                statement.setInt(2, time);
                statement.setDate(3, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(4, game.getUser().getId());
                statement.executeUpdate();
            }
            return 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
}