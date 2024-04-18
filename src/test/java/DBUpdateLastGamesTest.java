import com.example.infinite.DatabaseManager;
import com.example.infinite.Element;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;
import java.text.SimpleDateFormat;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

public class DBUpdateLastGamesTest {
    private DatabaseManager db;
    int result;
    SimpleDateFormat sdf;

    @Before
    public void setUp() {
        sdf = new SimpleDateFormat("yyyy-MM-dd");
        try{
            db = new DatabaseManager();
        } catch (SQLException e){
        }
    }

    @After
    public void tearDown(){
    }

    @Test
    public void testUpdateLastGames() {
        boolean pass  = true;
        try{
            db.updateLastGames(sdf.parse("2024-04-18"));
            Element el = db.getElementDay(sdf.parse("2024-04-18"));
            System.out.println(el);
            for(var d : db.getDates()){
                System.out.println(d);
            }

        } catch(Exception e){
            pass = false;
            e.printStackTrace();
        }
        assertEquals(true, pass);
    }
}

