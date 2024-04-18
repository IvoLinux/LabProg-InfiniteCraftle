package com.example.infinite.ai;

public class ModelBuilder {

    private String apiKey;
    private String modelTask = "completions";
    private String modelEngine = "chat";
    private String modelVersion = "v1";
    private int maxTokens = 10;
    private float temp = 0;

    enum ModelType{
        IC("ic"),
        BASE("base");
        private final String type;

        ModelType(String type) {
            this.type = type;
        }

        public String getType() {
            return type;
        }
    }


    public ModelBuilder() {

    }

    public ModelBase build(String modelType) throws RuntimeException {
        String url = "https://api.openai.com/%s/%s/%s";
        url = String.format(url, this.modelVersion, this.modelEngine, this.modelTask);
        String apiKey = this.apiKey;
        int maxTokens = this.maxTokens;
        float temperature = this.temp;
        if(modelType.equals(ModelType.IC.getType())){
            return new ICModel(url, apiKey, maxTokens, temperature);
        }
        else if (modelType.equals(ModelType.BASE.getType())){
            return new ModelBase(url, apiKey, maxTokens, temperature);
        }
        else throw new RuntimeException("Model type not supported");
    }

    public ModelBuilder APIKey(String apiKey) {
        this.apiKey = apiKey;
        return this;
    }

    public ModelBuilder modelEngine(String modelEngine) {
        this.modelEngine = modelEngine;
        return this;
    }

    public ModelBuilder modelVersion(String modelVersion) {
        this.modelVersion = modelVersion;
        return this;
    }

    public ModelBuilder maxTokens(int maxTokens) {
        this.maxTokens = maxTokens;
        return this;
    }

    public ModelBuilder task(String task) {
        this.modelTask = task;
        return this;
    }

    public ModelBuilder temperature(float temperature) {
        this.temp = temperature;
        return this;
    }
}
