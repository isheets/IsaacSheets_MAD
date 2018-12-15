package com.example.isaac.sheets_final;

public class PizzaInfo {

    private String pizza;
    private String pizzaShop = "";

    public void setPizzaInfo(String userPizza, Boolean glutenFree) {
        pizza = userPizza;
        if (glutenFree == true) {
            pizzaShop = "Boss Lady is a good place to get your pizza.";
        }
        else {
            pizzaShop = "Cosmos is a good place to get your pizza.";
        }
    }

    public String getPizza() {

        return pizza;
    }

    public String getPizzaShop() {
        return pizzaShop;
    }


}
