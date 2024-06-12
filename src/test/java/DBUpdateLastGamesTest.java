import com.example.infinite.DatabaseManager;
import com.example.infinite.domain.Element;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.text.SimpleDateFormat;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertThrows;

public class DBUpdateLastGamesTest {
    private DatabaseManager db;
    int result;
    SimpleDateFormat sdf;
    String date;

    @Before
    public void setUp() {
        date = "2024-04-23";
        sdf = new SimpleDateFormat("yyyy-MM-dd");
    }

    @After
    public void tearDown(){
    }

    @Test
    public void testUpdateLastGames() {
        assertThrows(Exception.class, () -> {
            db = DatabaseManager.getInstance();
        });
        boolean pass  = true;
        try{
            db.updateLastGames(sdf.parse(date));
            Element el = db.getElementDay(sdf.parse(date));
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

