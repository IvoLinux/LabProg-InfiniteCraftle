import com.example.infinite.DatabaseManager;
import static org.junit.Assert.assertEquals;

import com.example.infinite.User;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;

public class DBRegisterTest {

    private DatabaseManager db;
    private User user;
    private String username, password;
    int result;

    @Before
    public void setUp() {
        username = "fhsnjdasmok";
        password = "andiashbdinasmk";
        user = new User(username, password);
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
        result = db.removeUser(user);
        assertEquals(0, result);
        result = db.registerUser(user);
        assertEquals(0, result);
        result = db.registerUser(user);
        assertEquals(1, result);
        result = db.removeUser(user);
        assertEquals(0, result);
    }
}

