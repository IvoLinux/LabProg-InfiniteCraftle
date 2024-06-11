package com.example.infinite.dto;

import java.text.ParseException;
import java.text.SimpleDateFormat;

public class CraftRequest {
    private String parent1;
    private String parent2;
    private String gameDate;
    private int userId;

    public CraftRequest(String parent1, String parent2) {
        this.parent1 = parent1;
        this.parent2 = parent2;
    }
    public void setGameDate(String gameDate){
        this.gameDate = gameDate;
    }
    public java.util.Date getGameDate(){
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try {
            return formatter.parse(gameDate);
        } catch (ParseException e) {
            e.printStackTrace();
            return null;
        }
    }
    /**
     * Getter for parent1
     * @return parent1
     */
    public String getParent1() {
        return parent1;
    }

    /**
     * Getter for parent2
     * @return parent2
     */
    public String getParent2() {
        return parent2;
    }

    /**
     * Setter for parent2
     * @param parent2 parent2
     */
    public void setParent2(String parent2) {
        this.parent2 = parent2;
    }

    /**
     * Setter for parent1
     * @param parent1 parent1
     */
    public void setParent1(String parent1) {
        this.parent1 = parent1;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }
}
