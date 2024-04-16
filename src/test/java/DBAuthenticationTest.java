import com.example.infinite.DatabaseManager;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;

import static org.junit.Assert.assertEquals;

public class DBAuthenticationTest {

    private DatabaseManager db;
    private String username, password;
    int result;

    @Before
    public void setUp() {
        username = "fhsnjdasmok";
        password = "andiashbdinasmk";
        try{
            db = new DatabaseManager();
        } catch (SQLException e){
        }
    }

    @After
    public void tearDown(){
    }

    @Test
    public void testAuthenticateUser() {
        result = db.removeUser(username);
        assertEquals(0, result);
        result = db.authenticateUser(username, password);
        assertEquals(3, result);
        result = db.registerUser(username, password);
        assertEquals(0, result);
        result = db.authenticateUser(username, password + 'a');
        assertEquals(2, result);
        result = db.authenticateUser(username, password);
        assertEquals(0, result);
        result = db.removeUser(username);
        assertEquals(0, result);
    }
}

