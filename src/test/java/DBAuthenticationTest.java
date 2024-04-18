import com.example.infinite.DatabaseManager;
import com.example.infinite.User;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;

import static org.junit.Assert.assertEquals;

public class DBAuthenticationTest {

    private DatabaseManager db;
    private String username, password;
    User user, user2;
    int result;

    @Before
    public void setUp() {
        username = "fhsnjdasmok";
        password = "andiashbdinasmk";
        user = new User(username, password);
        user2 = new User(username, 'a' + password);
        try{
            db = new DatabaseManager();

        } catch (SQLException e){
            e.printStackTrace();
        }
    }

    @After
    public void tearDown(){
    }

    @Test
    public void testAuthenticateUser() {
        result = db.removeUser(user);
        assertEquals(0, result);
        result = db.authenticateUser(user);
        assertEquals(3, result);
        result = db.registerUser(user);
        assertEquals(0, result);
        result = db.authenticateUser(user2);
        assertEquals(2, result);
        result = db.authenticateUser(user);
        assertEquals(0, result);
        result = db.removeUser(user);
        assertEquals(0, result);
    }
}

