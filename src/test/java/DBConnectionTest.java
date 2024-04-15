import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBConnectionTest {
    // JDBC URL, username, and password of MySQL server
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/infinitecraftledb";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "root@icraftle";

    public static void main(String[] args) {
        try {
            // Establish a connection to the database
            Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
            System.out.println("Connected to the database.");

            // Create a statement object for executing SQL queries
            Statement statement = connection.createStatement();

            // Execute a simple SQL query to verify the connection
            ResultSet resultSet = statement.executeQuery("SELECT NOW()");
            while (resultSet.next()) {
                System.out.println("Current timestamp from the database: " + resultSet.getTimestamp(1));
            }
            // Execute an SQL INSERT statement to add an element to the Element table
            //String insertQuery = "INSERT INTO Element (element_id, name, emoji) VALUES (1, 'Water', '💧')";
            String insertQuery = "INSERT INTO Element (element_id, name, emoji) VALUES (2, 'Fire', '🔥')";
            int rowsAffected = statement.executeUpdate(insertQuery);

            if (rowsAffected > 0) {
                System.out.println("Element inserted successfully.");
            } else {
                System.out.println("Failed to insert element.");
            }
            // Close the resources
            resultSet.close();
            statement.close();
            connection.close();
            System.out.println("Connection closed.");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
