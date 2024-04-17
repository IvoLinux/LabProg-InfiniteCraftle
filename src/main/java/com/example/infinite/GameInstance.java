package com.example.infinite;

import java.util.ArrayList;

public class GameInstance {
    private double score;
    private long timeMillis;
    private boolean win;
    ArrayList<Element> elements;
    GameInstance(){
        this.score = 0;
        this.timeMillis = 0;
        this.win = false;
        elements = new ArrayList<>();
    }
    public void setEndGame(double score,long timeMillis,boolean win){
        this.score = score;
        this.timeMillis = timeMillis;
        this.win = win;
    }
}
