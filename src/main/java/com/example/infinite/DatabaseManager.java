package com.example.infinite;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.*;
import java.util.ArrayList;
import java.util.List;

public class DatabaseManager {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/infinitecraftledb";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root@icraftle";
    private static final int INITIAL_POOL_SIZE = 20;
    private List<Connection> pool;

    public DatabaseManager() throws SQLException {
        pool = new ArrayList<>();
        initializePool();
    }
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
    public int removeUser(String username) {
        Connection connection = null;
        try {
            connection = getConnection();
            String queryDelete = "DELETE FROM User WHERE username = ?";
            PreparedStatement statementDelete = connection.prepareStatement(queryDelete);
            statementDelete.setString(1, username);
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
    public int registerUser(String username, String password) {
        Connection connection = null;
        try {
            connection = getConnection();
            // Check if the username already exists
            String queryCheck = "SELECT COUNT(*) FROM User WHERE username = ?";
            try (PreparedStatement statementCheck = connection.prepareStatement(queryCheck)) {
                statementCheck.setString(1, username);
                try (ResultSet resultSet = statementCheck.executeQuery()) {
                    if (resultSet.next() && resultSet.getInt(1) > 0) {
                        return 1; // Username already exists
                    }
                }
            }

            // If the username doesn't exist, register the user
            String salt = BCrypt.gensalt(); // Generate a salt
            String hashedPassword = BCrypt.hashpw(password, salt); // Hash the password with the salt
            String queryInsert = "INSERT INTO User (username, password_hash) VALUES (?, ?)";
            try (PreparedStatement statementInsert = connection.prepareStatement(queryInsert)) {
                statementInsert.setString(1, username);
                statementInsert.setString(2, hashedPassword);
                int rowsAffected = statementInsert.executeUpdate();
                if (rowsAffected > 0) {
                    return 0; // User registered successfully
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
    public int authenticateUser(String username, String password) {
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;
        try {
            connection = getConnection();
            String query = "SELECT * FROM User WHERE username = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, username);

            // Execute the query
            resultSet = statement.executeQuery();

            // Check if a user with the given username exists
            if (resultSet.next()) {
                // Retrieve the hashed password and salt from the database
                String storedPasswordHash = resultSet.getString("password_hash");

                // Verify the provided password against the stored hash
                if (BCrypt.checkpw(password, storedPasswordHash)) {
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
    public int craftElement(Element parent1, Element parent2, Element element){
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
                statement.execute();
                return 0; // Success
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
    public int queryElement(Element parent1, Element parent2, Element element){
        loadElement(parent1);
        loadElement(parent1);
        Connection connection = null;
        try {
            connection = getConnection();
            String query = "SELECT name, emoji " +
                    "FROM Element e JOIN ElementsCrafted ec " +
                    "ON e.element_id = ec.child_id " +
                    "WHERE parent1_id = ? AND parent2_id = ?";
            try (PreparedStatement statement = connection.prepareStatement(query)) {
                statement.setInt(1, parent1.getId());
                statement.setInt(2, parent2.getId());

                try (ResultSet resultSet = statement.executeQuery()) {
                    if (resultSet.next()) {
                        element.setName(resultSet.getString("name"));
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
            return -1; // Error occurred during database operation
        }
        finally {
            if (connection != null){
                releaseConnection(connection);
            }
        }
    }
}