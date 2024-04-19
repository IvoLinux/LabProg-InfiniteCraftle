package com.example.infinite;

public class Element {
    private String name;
    private int depth, id;
    private String emoji;
    private Element parent1, parent2;

    public Element(String name, String emoji, int depth, Element parent1, Element parent2) {
        this.id = 0;
        this.name = name;
        this.emoji = emoji;
        this.depth = depth;
        this.parent1 = parent1;
        this.parent2 = parent2;
    }

    // Constructor with default depth and null parents
    public Element(String name, String emoji) {
        this(name, emoji, 0, null, null);
    }

    // Default constructor
    public Element() {
        this(null, null);
    }

    // Constructor with null parents
    public Element(String name, String emoji, int depth) {
        this(name, emoji, depth, null, null);
    }

    // Getters and setters for name
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    // Getters and setters for depth
    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    // Getters and setters for id
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // Getters and setters for emoji
    public String getEmoji() {
        return emoji;
    }

    public void setEmoji(String emoji) {
        this.emoji = emoji;
    }

    // Getters and setters for parent1 and parent2
    public Element getParent1() {
        return parent1;
    }

    public void setParent1(Element parent1) {
        this.parent1 = parent1;
    }

    public Element getParent2() {
        return parent2;
    }

    public void setParent2(Element parent2) {
        this.parent2 = parent2;
    }
}
