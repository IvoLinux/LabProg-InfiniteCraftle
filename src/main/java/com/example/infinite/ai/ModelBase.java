package com.example.infinite.ai;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.ProtocolException;
import java.net.URL;

public class ModelBase {
    private URL url;
    private final String apiKey;
    private final int maxTokens;
    private final String requestBody = "{\"model\": \"gpt-3.5-turbo\", \"messages\": [{\"role\": \"user\", \"content\": \" %s \"}], \"temperature\": %f, \"max_tokens\": %d}";
    private final float temperature;

    public static ModelBuilder builder() {
        return new ModelBuilder();
    }

    public ModelBase(String url, String apiKey, int maxTokens, float temperature) {
        try {
            this.url = new URL(url);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        this.apiKey = apiKey;
        this.maxTokens = maxTokens;
        this.temperature = temperature;
    }

    private String formatSendMessage(String msg){
        return String.format(requestBody, msg, temperature, maxTokens);
    }

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

    public String retrieveAnswer(String msg) {
        String answer = retrieveFullAnswer(msg);
        return answer.substring(answer.indexOf("content") + 11, answer.indexOf("\"", answer.indexOf("content") + 11));
    }
}
