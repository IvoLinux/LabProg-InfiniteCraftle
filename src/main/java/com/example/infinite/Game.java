package com.example.infinite;

import java.util.ArrayList;
import java.util.Date;

public class Game {
    private int score;
    private int timeMillis;
    private boolean win;
    private ArrayList<Element> elements;
    private Date date;
    private User user;

    public Game(Date date, User user) {
        this.date = date;
        this.user = user;
        this.score = 0;
        this.timeMillis = 0;
        this.win = false;
        this.elements = new ArrayList<>();
    }

    // Getter for date
    public Date getDate() {
        return date;
    }

    // Getter for user
    public User getUser() {
        return user;
    }

    // Getter and setter for score
    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    // Getter and setter for timeMillis
    public int getTimeMillis() {
        return timeMillis;
    }

    public void setTimeMillis(int timeMillis) {
        this.timeMillis = timeMillis;
    }

    // Getter and setter for win
    public boolean isWin() {
        return win;
    }

    public void setWin(boolean win) {
        this.win = win;
    }

    // Getter and setter for elements
    public ArrayList<Element> getElements() {
        return elements;
    }

    public void setElements(ArrayList<Element> elements) {
        this.elements = elements;
    }

    // Method to set game end details
    public void setEndGame(int score, int time, boolean win) {
        setScore(score);
        setTimeMillis(time);
        setWin(win);
    }
}