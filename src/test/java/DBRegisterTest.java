import com.example.infinite.DatabaseManager;
import static org.junit.Assert.assertEquals;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class DBRegisterTest {

    private DatabaseManager db;
    private String username, password;
    int result;

    @Before
    public void setUp() {
        db = DatabaseManager.getInstance();
        username = "fhsnjdasmok";
        password = "andiashbdinasmk";
    }

    @After
    public void tearDown() {
        db.closeConnection();
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

