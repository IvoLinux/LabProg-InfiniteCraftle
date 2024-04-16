package com.example.infinite;

import java.io.*;
import com.google.gson.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class MainServlet extends HttpServlet {
    private String message;
    private DatabaseManager databaseManager;

    public void init() {
        message = "SUP JIZZERS!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/html");

        // Hello
        PrintWriter out = response.getWriter();
        out.println("<html><body>");
        out.println("<h1>" + message + "</h1>");
        out.println("</body></html>");
    }
    public void doPut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // Read JSON payload from request
        BufferedReader reader = request.getReader();
        StringBuilder jsonPayload = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            jsonPayload.append(line);
        }

        // Parse JSON payload
        JsonObject jsonObject = JsonParser.parseString(jsonPayload.toString()).getAsJsonObject();
        String username = jsonObject.get("username").getAsString();
        String password = jsonObject.get("password").getAsString();

        // Register the user into the database
        int code = databaseManager.registerUser(username, password);

        // Set content type to JSON
        response.setContentType("application/json");

        // Send response
        JsonObject jsonResponse = new JsonObject();
        jsonResponse.addProperty("code", code);
        jsonResponse.addProperty("message", ErrorCodeDictionary.getErrorMessage(code));
        PrintWriter out = response.getWriter();
        out.println(jsonResponse.toString());
    }


    public void destroy() {
    }
}