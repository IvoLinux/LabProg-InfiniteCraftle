package com.example.infinite;

import com.example.infinite.ai.ICModel;

public class HelloServlet {
    public static void main(String[] args){
        ICModel model = ICModel.buildDefault("API_KEY", 10, 0.7f);
        String ret = model.retrieveAnswer("Cat", "Dog");
        System.out.println(ret);
    }
}