import com.example.infinite.DatabaseManager;
import com.example.infinite.Element;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;

import static org.junit.Assert.assertEquals;

public class DBElementQueryTest {

    private DatabaseManager db;
    Element el, p1, p2;
    int result;

    @Before
    public void setUp() {
        try{
            db = new DatabaseManager();
        } catch (SQLException e){
        }
        p1 = new Element("water1", "💧");
        p2 = new Element("fire1", "🔥");
        el = new Element("steam1", "💨");
    }

    @After
    public void tearDown(){
    }

    @Test
    public void testAuthenticateUser() {
        assertEquals(0, db.addElement(p1));
        assertEquals(0, db.addElement(p2));
        assertEquals(0, db.addElement(el));
        assertEquals(-1, db.queryElement(p1, p2, el));
        assertEquals(0, db.craftElement(p1, p2, el));
        assertEquals(0, db.queryElement(p1, p2, el));
        assertEquals(0, db.removeElement(el));
        assertEquals(0, db.removeElement(p2));
        assertEquals(0, db.removeElement(p1));
    }
}

