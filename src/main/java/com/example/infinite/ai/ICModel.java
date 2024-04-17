package com.example.infinite.ai;

public class ICModel extends ModelBase {

    private String zeroShotLearningTemplate;
    private int counter = 0;

    public ICModel(String url, String apiKey, int maxTokens, float temperature) {
        super(url, apiKey, maxTokens, temperature);
        zeroShotLearningTemplate = "What is the answer that best fits the operands? Choose only one answer: ";
    }

    public void updateTemplate(String operand1, String operand2, String answer){
        if(counter < 5){
            zeroShotLearningTemplate += String.format("%s + %s = %s; ", operand1, operand2, answer);
            counter++;
        }

    }

    public String addQuestion(String op1, String op2){
        String question = String.format("%s + %s = ", op1, op2);
        return zeroShotLearningTemplate + question;
    }

    public String retrieveAnswer(String op1, String op2){
        String question = addQuestion(op1, op2);

        String ret = super.retrieveAnswer(question);
        updateTemplate(op1, op2, ret);
        return ret;
    }

    public String[] getNewCraft(String parent1, String parent2, String emoji1, String emoji2){
        String ret = retrieveAnswer(emoji1+parent1, emoji2+parent2);
        return new String[]{String.valueOf(ret.charAt(0)), ret.substring(1)};
    }
}
