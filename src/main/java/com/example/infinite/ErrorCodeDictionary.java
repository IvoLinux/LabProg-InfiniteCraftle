package com.example.infinite;
import java.util.HashMap;
import java.util.Map;

public class ErrorCodeDictionary {
    // Static dictionary mapping error codes to error messages
    private static final Map<Integer, String> errorMessages = new HashMap<>();

    // Static initializer to populate the dictionary
    static {
        errorMessages.put(0, "success");
        errorMessages.put(1, "Registration failed: user already exists");
        errorMessages.put(2, "Authentication failed: incorrect password");
        errorMessages.put(3, "Authentication failed: user does not exist");
        errorMessages.put(4, "Invalid date");
        errorMessages.put(-1, "calma ai biggers deu ruim aqui");

    }

    // Method to get error message by error code
    public static String getErrorMessage(int errorCode) {
        return errorMessages.getOrDefault(errorCode, "Unknown Error");
    }
}