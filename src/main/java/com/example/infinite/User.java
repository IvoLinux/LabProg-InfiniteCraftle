package com.example.infinite;

public class User {
    private String username, password;
    private int id;
    public User(String username, String password){
        this.username = username;
        this.password = password;
        this.id = 0;
    }
    void setId(int id){
        this.id = id;
    }
    int getId(){
        return id;
    }
    String getUsername(){
        return username;
    }
    String getPassword(){
        return password;
    }
}
