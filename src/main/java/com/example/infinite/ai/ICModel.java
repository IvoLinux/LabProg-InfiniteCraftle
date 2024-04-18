package com.example.infinite.ai;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

public class ICModel extends ModelBase {

    private String zeroShotLearningTemplate;
    private int counter = 0;

    public static ICModel buildDefault(String apiKey, int maxTokens, float temperature){
        return new ICModel("https://api.openai.com/v1/chat/completions", apiKey, maxTokens, temperature);
    }

    private String getPromptTemplate(){
        StringBuilder sb = new StringBuilder();
        try {
            File myObj = new File("./src/main/resources/prompt.txt"); // Check for Windows
            Scanner myReader = new Scanner(myObj);
            while (myReader.hasNextLine()) {
                sb.append(myReader.nextLine());
                sb.append("  ");
            }
            myReader.close();
        } catch (FileNotFoundException e) {
            System.out.println("An error occurred.");
            e.printStackTrace();
        }
        return sb.toString();
    }

    public ICModel(String url, String apiKey, int maxTokens, float temperature) {
        super(url, apiKey, maxTokens, temperature);
    }

    public String addQuestion(String op1, String op2){
        String prompt = getPromptTemplate();
        return prompt.replace("<input>", String.format("%s, %s", op1, op2));
    }

    public String retrieveAnswer(String op1, String op2){
        String question = addQuestion(op1, op2);

        return super.retrieveAnswer(question);
    }

    public String[] getNewCraft(String parent1, String parent2, String emoji1, String emoji2){
        String ret = retrieveAnswer(emoji1+parent1, emoji2+parent2);
        if(ret.equals("None")) return null;
        return ret.split(" ");
    }
}
