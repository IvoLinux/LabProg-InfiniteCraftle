package com.example.infinite;

import java.io.IOException;

import com.example.infinite.api.SignupApiServlet;
import com.example.infinite.dto.SignUpResponse;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignupServlet
 * The value attribute defines the URL pattern that the servlet will listen to
 */
@WebServlet(name = "signup", value = "/signup")
public class SignupServlet extends HttpServlet {

    /**
     * doGet method is called when the client sends a GET request to the server
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException when an input or output exception occurs during IO operations
     * @throws ServletException when a servlet exception occurs
     * The method forwards the request to the index.jsp file in the signup folder
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.getRequestDispatcher("/signup/index.jsp").forward(request, response);
    }

    /**
     * doPost method is called when the client sends a POST request to the server
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException
     * The method gets the username and password from the request and creates a new User object
     * The method then calls the registerUser method from the DatabaseManager class to register
     * the user in the database
    */
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        SignUpResponse signUpResponse = SignupApiServlet.handleSignup(username, password, confirmPassword);
        request.getSession().setAttribute("signup-error", signUpResponse.getError());
        if(signUpResponse.getError().isEmpty()){
            response.sendRedirect("/login");
        } else{
            response.sendRedirect("/signup");
        }
    }

    /**
     * destroy method is called when the servlet is removed from service
     */
    public void destroy() {
    }
}
