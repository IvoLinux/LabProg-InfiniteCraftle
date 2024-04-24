package com.example.infinite;


import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;

/**
 * Servlet implementation class LoginServlet
 * The value attribute defines the URL pattern that the servlet will listen to
 * The name attribute defines the name of the servlet
 */
@WebServlet(name = "login", value = "/login")
public class LoginServlet extends HttpServlet {

    /**
     * doGet method is called when the client sends a GET request to the server
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException when an input or output exception occurs during IO operations
     * @throws ServletException when a servlet exception occurs
     * The method forwards the request to the index.jsp file in the login folder
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/login/index.jsp").forward(request, response);
    }

    /**
     * doPost method is called when the client sends a POST request to the server
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException
     * The method gets the username and password from the request and creates a new User object
     * The method then calls the authenticateUser method from the DatabaseManager class to authenticate
     * the user in the database
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = new User(username, password);
        //cria User e passa por referencia pro authenticate tudo com Username vira user
        try {
            DatabaseManager databaseManager = new DatabaseManager();
            int code = databaseManager.authenticateUser(user);
            System.out.println(code);
            if (code != 0) {
                request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code));
                response.sendRedirect("/login");
                return;
            } else {
                //Aqui recebe os dados do jogo de hoje, com a lista de elementos
                Game game = new Game(new java.util.Date(), user);
                int code2 = databaseManager.getGame(game);
                if (code2 != 0) {
                    request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(code2));
                    response.sendRedirect("/login");
                    return;
                }
                //Aqui recebe a lista de jogos já ganhos com os scores e tempos
                List<java.util.Date> listDates = databaseManager.getDates();
                request.getSession().setAttribute("elementDay", databaseManager.getElementDay(new java.util.Date()));
                request.getSession().setAttribute("initialTime", System.currentTimeMillis());
                request.getSession().setAttribute("error", null);
                request.getSession().setAttribute("user", user);
                request.getSession().setAttribute("listDates", listDates);
                request.getSession().setAttribute("game", game);
                response.sendRedirect("/");
                return;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
        }
        response.sendRedirect("/login");
    }

    /**
     * destroy method is called when the servlet is being destroyed
     */
    public void destroy() {
    }
}
