package com.example.infinite.dto;

import com.example.infinite.domain.Element;
import com.example.infinite.domain.Game;

public class ChangeDateResponse {
    private String error;
    private Game game;
    public String getError() {
        return error;
    }
    public void setError(String error) {
        this.error = error;
    }
    public Game getGame() {
        return game;
    }
    public void setGame(Game game) {
        this.game = game;
    }
}
