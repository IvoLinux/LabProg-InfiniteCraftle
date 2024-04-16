import com.example.infinite.DatabaseManager;
import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;

public class DBRegisterTest {

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
    public void tearDown() {
    }

    @Test
    public void testRegisterUser() {
        result = db.removeUser(username);
        assertEquals(0, result);
        result = db.registerUser(username, password);
        assertEquals(0, result);
        result = db.registerUser(username, password);
        assertEquals(1, result);
        result = db.removeUser(username);
        assertEquals(0, result);
    }
}

