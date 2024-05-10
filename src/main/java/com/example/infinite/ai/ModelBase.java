package com.example.infinite.ai;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.*;

/**
 * ModelBase class.
 * This class is the base class for the models based on GPT-3.5-turbo API.
 * It contains the URL, API key, maximum tokens, and temperature for the model.
 */
public class ModelBase {
    private URL url;
    private final String apiKey;
    private final int maxTokens;
    private final String requestBody = "{\"model\": \"gpt-3.5-turbo\", \"messages\": [{\"role\": \"user\", \"content\": \" %s \"}], \"temperature\": %f, \"max_tokens\": %d}";
    private final float temperature;

    /**
     * returns the builder for the base model
     * @return ModelBuilder
     */
    public static ModelBuilder builder() {
        return new ModelBuilder();
    }

    /**
     * Constructor for ModelBase
     * @param url url to the OpenAI API
     * @param apiKey API key for the OpenAI API
     * @param maxTokens maximum number of tokens to generate
     * @param temperature temperature for the model
     */
    public ModelBase(String url, String apiKey, int maxTokens, float temperature) {
        try {
            this.url = new URI(url).toURL();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        this.apiKey = apiKey;
        this.maxTokens = maxTokens;
        this.temperature = temperature;
    }

    /**
     * Formats the message to be sent to the OpenAI API
     * @param msg message to be sent
     * @return
     */
    private String formatSendMessage(String msg){
        return String.format(requestBody, msg, temperature, maxTokens);
    }

    /**
     * Retrieves the full answer from the OpenAI API
     * @param msg message to be sent
     * @return the full answer, a JSON in String format
     */
    public String retrieveFullAnswer(String msg) {
        HttpURLConnection conn;
        try {
            conn = (HttpURLConnection) url.openConnection();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        try {
            conn.setRequestMethod("POST");
        } catch (ProtocolException e) {
            throw new RuntimeException(e);
        }
        conn.setRequestProperty("Content-Type", "application/json");
        conn.setRequestProperty("Authorization", "Bearer " + apiKey);
        conn.setDoOutput(true);
        System.out.println("Request: " + msg);
        System.out.println(apiKey);
        try (OutputStream os = conn.getOutputStream()) {
            byte[] input = formatSendMessage(msg).getBytes("utf-8");
            os.write(input, 0, input.length);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        StringBuilder response = new StringBuilder();
        try (BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"))) {
            String responseLine;
            while ((responseLine = br.readLine()) != null) {
                response.append(responseLine.trim());
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        conn.disconnect();

        return response.toString();

    }

    /**
     * Retrieves the answer from the OpenAI API
     * @param msg message to be sent
     * @return the String answer formatted
     */
    public String retrieveAnswer(String msg) {
        String answer = retrieveFullAnswer(msg);
        System.out.println(answer);
        return answer.substring(answer.indexOf("content") + 11, answer.indexOf("\"", answer.indexOf("content") + 11));
    }
}
