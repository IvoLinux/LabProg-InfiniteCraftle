package com.example.infinite;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;

import com.example.infinite.dto.CraftRequest;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.example.infinite.ai.ICModel;



/**
 * Servlet implementation class HomeServlet. The value attribute defines the URL pattern that the servlet will listen to
 */
@WebServlet(name = "home", value = "/")
public class HomeServlet extends HttpServlet {
    /**
     * doGet method is called when the client sends a GET request to the server.
     * This method forwards the request to the index.jsp file in the home folder.
     * It verifies if a user is logged. If he isn't, redirects to the login page.
     * @param request HttpServletRequest object that contains the request the client has made to the server
     * @param response HttpServletResponse object that contains the response the server sends back to the client
     * @throws IOException when an error occurs while reading the request
     * @throws ServletException when an error occurs while forwarding the request
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        try {
            Game game = (Game) request.getSession().getAttribute("game");
            if(game == null) throw new Exception("game not set");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            request.getSession().setAttribute("error", ErrorCodeDictionary.getErrorMessage(6));
            response.sendRedirect("/login");
        }
    }
    public void destroy() {
    }
}




