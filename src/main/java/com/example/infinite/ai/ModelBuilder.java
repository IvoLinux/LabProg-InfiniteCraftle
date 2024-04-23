package com.example.infinite.ai;

/**
 * ModelBuilder is a class that is used to build a model object.
 * It is used to set the parameters for the model object.
 */
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

    /**
     * Constructor for ModelBuilder
     */
    public ModelBuilder() {

    }

    /**
     * Build a model object
     * @param modelType type of model to build
     * @return the model object
     * @throws RuntimeException if the model type is not supported
     */
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

    /**
     * Set the API key for the model
     * @param apiKey API key for the model
     * @return the model builder
     */
    public ModelBuilder APIKey(String apiKey) {
        this.apiKey = apiKey;
        return this;
    }

    /**
     * Set the model engine for the model
     * @param modelEngine model engine for the model
     * @return the model builder
     */
    public ModelBuilder modelEngine(String modelEngine) {
        this.modelEngine = modelEngine;
        return this;
    }

    /**
     * Set the model version for the model
     * @param modelVersion model version for the model
     * @return the model builder
     */
    public ModelBuilder modelVersion(String modelVersion) {
        this.modelVersion = modelVersion;
        return this;
    }

    /**
     * Set the maximum number of tokens for the model
     * @param maxTokens maximum number of tokens for the model
     * @return the model builder
     */
    public ModelBuilder maxTokens(int maxTokens) {
        this.maxTokens = maxTokens;
        return this;
    }

    /**
     * Set the task for the model
     * @param task task for the model
     * @return the model builder
     */
    public ModelBuilder task(String task) {
        this.modelTask = task;
        return this;
    }

    /**
     * Set the temperature for the model
     * @param temperature temperature for the model
     * @return the model builder
     */
    public ModelBuilder temperature(float temperature) {
        this.temp = temperature;
        return this;
    }
}
