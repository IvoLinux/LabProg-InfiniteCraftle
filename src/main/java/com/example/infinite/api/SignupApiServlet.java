package com.example.infinite.api;

import com.example.infinite.*;
import com.example.infinite.dto.SignUpResponse;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
/**
 * Servlet implementation class SignupServlet
 * The value attribute defines the URL pattern that the servlet will listen to
 */
@WebServlet(name = "signup-api", value = "/api/signup")
public class SignupApiServlet extends HttpServlet {

    /**
     * doGet method is called when the client sends a GET request to the server
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException when an input or output exception occurs during IO operations
     * @throws ServletException when a servlet exception occurs
     * The method forwards the request to the index.jsp file in the signup folder
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm-password");
        SignUpResponse signUpResponse = handleSignup(username, password, confirmPassword);
        response.setHeader("Access-Control-Allow-Origin", "*"); // Allow all origins
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Accept, X-Requested-With, remember-me");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String jsonString = gson.toJson(signUpResponse);
        out.println(jsonString);
    }
    public static SignUpResponse handleSignup(String username, String password, String confirmPassword){
        SignUpResponse response = new SignUpResponse();
        if(!password.equals(confirmPassword)){
            response.setError(ErrorCodeDictionary.getErrorMessage(8));
            return response;
        }
        if(password.length() < 8){
            response.setError(ErrorCodeDictionary.getErrorMessage(9));
            return response;
        }
        DatabaseManager databaseManager;
        User user = new User(username, password);
        try{
            databaseManager = DatabaseManager.getInstance();
        } catch (Exception e){
            response.setError(ErrorCodeDictionary.getErrorMessage(6));
            return response;
        }
        int code = databaseManager.registerUser(user);
        if(code != 0){
            response.setError(ErrorCodeDictionary.getErrorMessage(code));
            return response;
        }
        return response;
    }

    /**
     * destroy method is called when the servlet is removed from service
     */
    public void destroy() {
    }
}
