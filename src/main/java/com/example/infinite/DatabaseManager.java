package com.example.infinite;
import java.io.Console;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.mindrot.jbcrypt.*;

public class DatabaseManager {
    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/infinitecraftledb";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root@icraftle";

    // Singleton instance
    private static DatabaseManager instance;

    // Connection object
    private Connection connection;

    // Private constructor to prevent instantiation
    private DatabaseManager() {
        try {
            // Establish a connection to the database
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            System.out.println("Connected to the database.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Get the singleton instance
    public static DatabaseManager getInstance() {
        if (instance == null) {
            synchronized (DatabaseManager.class) {
                if (instance == null) {
                    instance = new DatabaseManager();
                }
            }
        }
        return instance;
    }

    // Get the database connection
    public Connection getConnection() {
        return connection;
    }

    // Close the database connection
    public void closeConnection() {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Connection closed.");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public int removeUser(String username){
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
        }
        return -1; // Error occurred while registering the user
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
            System.out.println(salt + " "  + salt.length());
            System.out.println(hashedPassword + " " + hashedPassword.length());

            String queryInsert = "INSERT INTO User (username, password_salt, password_hash) VALUES (?, ?, ?)";
            try (PreparedStatement statementInsert = connection.prepareStatement(queryInsert)) {
                statementInsert.setString(1, username);
                statementInsert.setString(2, salt);
                statementInsert.setString(3, hashedPassword);
                int rowsAffected = statementInsert.executeUpdate();
                if (rowsAffected > 0) {
                    return 0; // User registered successfully
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Error occurred while registering the user
    }
}
