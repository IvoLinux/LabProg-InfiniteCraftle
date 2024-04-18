package com.example.infinite;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.*;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class DatabaseManager {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/infinitecraftledb";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root@icraftle";
    private static final int INITIAL_POOL_SIZE = 20;
    private List<Connection> pool;
    private void initializePool() throws SQLException {
        for (int i = 0; i < INITIAL_POOL_SIZE; i++) {
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            pool.add(connection);
        }
    }
    private synchronized Connection getConnection() throws SQLException {
        if (pool.isEmpty()) {
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        }
        return pool.remove(pool.size() - 1);
    }
    private synchronized void releaseConnection(Connection connection) {
        pool.add(connection);
    }
    private int loadElement(Element element) {
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT element_id, depth \n" +
                    "FROM Element \n" +
                    "WHERE name = ? \n" +
                    "ORDER BY depth DESC \n" +
                    "LIMIT 1\n";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setString(1, element.getName());
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        System.out.println("oi: " + resultSet.getInt("element_id"));
                        element.setId(resultSet.getInt("element_id"));
                        element.setDepth(resultSet.getInt("depth"));
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
    private int storeCraftedElement(Game game, int element_id){
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
                statement.setInt(3, element_id);
                statement.setDate(4, new java.sql.Date(game.getDate().getTime()));
                statement.setInt(5, game.getUser().getId());
                statement.setInt(6, element_id);
                statement.execute();
                game.setElements(getElementList(game));
                return 0;
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
                    // adicionar elementos padrao
                    return storeCraftedElement(game, 1) &
                            storeCraftedElement(game, 2) &
                            storeCraftedElement(game, 3) &
                            storeCraftedElement(game, 4);
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
    public DatabaseManager() throws SQLException {
        pool = new ArrayList<>();
        initializePool();
    }
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
    public int addElement(Element element){
        Connection connection = null;
        try {
            connection = getConnection();
            String queryInsert = "INSERT INTO Element (name, emoji, depth) VALUES (?, ?, ?)";
            try (PreparedStatement statementInsert = connection.prepareStatement(queryInsert)) {
                statementInsert.setString(1, element.getName());
                statementInsert.setString(2, element.getEmoji());
                statementInsert.setInt(3, element.getDepth());
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
        System.out.println(element.getId());
        loadElement(element);
        System.out.println(element.getId());
        // Insert into ElementsCrafted table
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "INSERT INTO ElementsCrafted (parent1_id, parent2_id, child_id) VALUES (?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                //System.out.println(parent1.getId() + " " + parent2.getId() + " " + element.getId());
                statement.setInt(1, parent1.getId());
                statement.setInt(2, parent2.getId());
                statement.setInt(3, element.getId());
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    storeCraftedElement(game, element.getId());
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
    public int queryElement(Game game, Element parent1, Element parent2, Element element){
        loadElement(parent1);
        loadElement(parent1);
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT e.element_id, e.name, e.emoji " +
                    "FROM Element e JOIN ElementsCrafted ec " +
                    "ON e.element_id = ec.child_id " +
                    "WHERE ec.parent1_id = ? AND ec.parent2_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, parent1.getId());
                statement.setInt(2, parent2.getId());

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        element.setId(resultSet.getInt("element_id"));
                        element.setName(resultSet.getString("name"));
                        element.setEmoji(resultSet.getString("emoji"));
                        storeCraftedElement(game, element.getId());
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
    public void updateLastGames(java.util.Date gameDay){
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT MAX(date) AS most_recent_date FROM LastGames";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        java.sql.Date date = resultSet.getDate("most_recent_date");
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                        LocalDate currentDate = LocalDate.parse(date.toString(), formatter);
                        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); // Define your desired pattern
                        String dateString = sdf.format(gameDay);
                        System.out.println(dateString + " sasdasjdnasdl");
                        while(!date.toString().equals(dateString)){
                            currentDate = currentDate.plusDays(1);
                            date = java.sql.Date.valueOf(currentDate);
                            System.out.println(date.toString());
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
    public Element getElementDay(java.util.Date date){
        Element el = new Element("", "");
        java.sql.Date sqlDate = new java.sql.Date(date.getTime());
        String query = "SELECT element_id, name, emoji FROM Element e " +
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
        return el;
    }
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
    public void saveEndGame(Game game){
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
        } catch (SQLException e) {
            e.printStackTrace();
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
}