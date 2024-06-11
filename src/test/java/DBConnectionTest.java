import com.example.infinite.DatabaseManager;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

public class DBConnectionTest {

    private DatabaseManager db;
    boolean result;

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }

    @Test
    public void testConnectionDB() {
        assertThrows(Exception.class, () -> {
            db = DatabaseManager.getInstance();
        });
    }
}

