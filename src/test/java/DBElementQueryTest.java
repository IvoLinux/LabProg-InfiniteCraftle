import com.example.infinite.DatabaseManager;
import com.example.infinite.Element;
import com.example.infinite.Game;
import com.example.infinite.User;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import static org.junit.Assert.assertEquals;

public class DBElementQueryTest {
    private DatabaseManager db;
    Element el, p1, p2;
    Game game;
    User user;
    java.util.Date date;
    SimpleDateFormat sdf;

    @Before
    public void setUp() {
        try{
            db = DatabaseManager.getInstance();
            sdf = new SimpleDateFormat("yyyy-MM-dd");
            date = sdf.parse("2024-04-18");
            db.updateLastGames(date);
            user = new User("ebert", "ola");
            db.registerUser(user);
            game = new Game(date, user);
            db.getGame(game);
            game.setEndGame(3,3,true);
            p1 = new Element("water", "💧");
            p2 = new Element("fire", "🔥");
            el = new Element("steam", "💨");
        } catch (ParseException e){
        }
    }

    @After
    public void tearDown(){
    }

    @Test
    public void testQueryAndCraft() {
        db.removeElement(el);
        assertEquals(7, db.queryElement(game, p1, p2, el));
        assertEquals(0, db.craftElement(game, p1, p2, el));
        assertEquals(0, db.queryElement(game, p1, p2, el));
        db.saveEndGame(game);
        db.removeElement(el);

    }

}

