package com.example.isaac.sheets_final;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

public class RecievePizzaShop extends AppCompatActivity {

    String pizzaShop;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recieve_pizza_shop);

        Intent intent = getIntent();

        pizzaShop = intent.getStringExtra("pizzaShop");

        TextView displayShop = findViewById(R.id.pizzaShopText);

        displayShop.setText(pizzaShop);
    }
}
