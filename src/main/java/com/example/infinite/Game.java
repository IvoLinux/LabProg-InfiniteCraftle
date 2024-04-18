package com.example.infinite;

import java.util.ArrayList;

public class Game {
    private int score;
    private int timeMillis;
    private boolean win;
    private ArrayList<Element> elements;
    private java.util.Date date;
    private User user;

    public Game(java.util.Date date, User user) {
        this.date = date;
        this.user = user;
        this.score = 0;
        this.timeMillis = 0;
        this.win = false;
        this.elements = new ArrayList<Element>();
    }
    public java.util.Date getDate() {
        return date;
    }
    public User getUser() {
        return this.user;
    }
    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }

    public int getTimeMillis() {
        return timeMillis;
    }

    public void setTimeMillis(int timeMillis) {
        this.timeMillis = timeMillis;
    }

    public boolean isWin() {
        return win;
    }

    public void setWin(boolean win) {
        this.win = win;
    }

    public ArrayList<Element> getElements() {
        return elements;
    }

    public void setElements(ArrayList<Element> elements) {
        this.elements = elements;
    }

    public void setEndGame(int score, int time, boolean b) {
        setScore(score);
        setTimeMillis(time);
        setWin(b);
    }
}
