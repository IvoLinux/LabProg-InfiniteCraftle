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
    public synchronized Connection getConnection() throws SQLException {
        if (pool.isEmpty()) {
            return DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        }
        return pool.remove(pool.size() - 1);
    }

    public synchronized void releaseConnection(Connection connection) {
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
}