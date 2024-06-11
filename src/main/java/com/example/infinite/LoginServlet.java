package com.example.infinite;


import java.io.IOException;

import com.example.infinite.api.LoginApiServlet;
import com.example.infinite.dto.LoginResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LoginServlet.
 * The value attribute defines the URL pattern that the servlet will listen to.
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
     * The method checks if the username and password are correct. If they are, it forwards the request to the index.jsp file in the root folder
     */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        LoginResponse loginResponse = LoginApiServlet.handleLogin(username, password);
        if(!loginResponse.getError().isEmpty()) {
            request.getSession().setAttribute("login-error", loginResponse.getError());
            response.sendRedirect("/login");
            return;
        }
        request.getSession().setAttribute("login-error", loginResponse.getError());
        request.getSession().setAttribute("elementDay", loginResponse.getElementDay());
        request.getSession().setAttribute("initialTime", loginResponse.getInitialTime());
        request.getSession().setAttribute("listDates", loginResponse.getListDates());
        request.getSession().setAttribute("game", loginResponse.getGame());
        response.sendRedirect("/");
    }

    /**
     * destroy method is called when the servlet is being destroyed
     */
    public void destroy() {
    }
}
