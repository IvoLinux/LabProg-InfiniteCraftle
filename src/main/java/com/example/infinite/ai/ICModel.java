package com.example.infinite.ai;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

/**
 * ICModel is a class that represents the Infinite Craft model. It is a subclass of ModelBase.
 * It is used to interact with the OpenAI API to retrieve answers to questions.
 * It also contains a few helper functions to format the question and retrieve the answer.
 */
public class ICModel extends ModelBase {

    private String fewShotLearningTemplate;
    private int counter = 0;


    /**
     * Build a default ICModel
     * @param apiKey OPENAI API key
     * @param maxTokens maximum number of tokens
     * @param temperature temperature for the model
     * @return the default ICModel
     */
    public static ICModel buildDefault(String apiKey, int maxTokens, float temperature){
        return new ICModel("https://api.openai.com/v1/chat/completions", apiKey, maxTokens, temperature);
    }

    /**
     * Get the prompt template from the txt file 
     * @return the prompt template
     */
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

    /**
     * Constructor for ICModel
     * @param url url to the OpenAI API
     * @param apiKey API key for the OpenAI API
     * @param maxTokens maximum number of tokens to generate
     * @param temperature temperature for the model
     */
    public ICModel(String url, String apiKey, int maxTokens, float temperature) {
        super(url, apiKey, maxTokens, temperature);
    }

    /**
     * Format the question for the prompt
     * @param op1 first operand
     * @param op2 second operand
     * @return the prompt with the question added
     */
    public String addQuestion(String op1, String op2){
        String prompt = getPromptTemplate();
        return prompt.replace("<input>", String.format("%s, %s", op1, op2));
    }

    /**
     * Retrieve the answer to a prompt
     * @param op1 first operand
     * @param op2 second operand
     * @return the answer to the question
     */
    public String retrieveAnswer(String op1, String op2){
        String question = addQuestion(op1, op2);

        return super.retrieveAnswer(question);
    }

    /**
     * Get the new craft from the model. This is a helper function that calls retrieveAnswer
     * @param parent1 first parent
     * @param parent2 second parent
     * @param emoji1 emoji for the first parent
     * @param emoji2 emoji for the second parent
     * @return the new craft
     * If the model returns "None", return null
     */
    public String[] getNewCraft(String parent1, String parent2, String emoji1, String emoji2){
        String ret = retrieveAnswer(emoji1+parent1, emoji2+parent2);
        if(ret.equals("None")) return null;
        return ret.split(" ");
    }
}
