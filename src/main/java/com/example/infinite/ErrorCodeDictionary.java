package com.example.infinite;
import java.util.HashMap;
import java.util.Map;


/**
 * Class to map error codes to error messages.
 */
public class ErrorCodeDictionary {
    /**
     * Static dictionary mapping error codes to error messages
    */
     private static final Map<Integer, String> errorMessages = new HashMap<>();

    static {
        errorMessages.put(0, "success");
        errorMessages.put(1, "User already exists");
        errorMessages.put(8, "Passwords do not match");
        errorMessages.put(9, "Password should have at least 8 characters");
        errorMessages.put(2, "Incorrect password");
        errorMessages.put(3, "Username does not exist");
        errorMessages.put(4, "Add element failed: element already exists");
        errorMessages.put(5, "Searching failed: element not found");
        errorMessages.put(6, "DataBase connection failed");
        errorMessages.put(7, "Query failed: element not built");
        errorMessages.put(-1, "Internal error");

    }

    /**
     * Method to get the error message corresponding to an error code
     * @param errorCode the error code
     * @return the error message corresponding to the error code
    */
    public static String getErrorMessage(int errorCode) {
        return errorMessages.getOrDefault(errorCode, "Unknown Error");
    }
}