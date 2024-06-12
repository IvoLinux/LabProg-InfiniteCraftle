import com.example.infinite.DatabaseManager;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

import com.example.infinite.domain.User;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

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
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testRegisterUser() {
        assertThrows(Exception.class, () -> {
            db = DatabaseManager.getInstance();
        });
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

