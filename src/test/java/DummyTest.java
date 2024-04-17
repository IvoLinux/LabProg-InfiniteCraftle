import com.example.infinite.DatabaseManager;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static org.junit.Assert.assertEquals;

public class DummyTest {

    private DatabaseManager db;
    boolean result;

    @Before
    public void setUp() {
    }

    @After
    public void tearDown() {
    }
    public void oi(A a){
        a.set(2);
    }
    @Test
    public void test() {
        A a = new A();
        a.set(1);
        oi(a);
        System.out.println(a.get());
    }
}

