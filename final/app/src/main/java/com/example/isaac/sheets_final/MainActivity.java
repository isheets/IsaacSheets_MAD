package com.example.isaac.sheets_final;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Switch;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

public class MainActivity extends AppCompatActivity {

    private PizzaInfo userPizza = new PizzaInfo();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //pizza details button
        Button pizzaButton = findViewById(R.id.getPizzaButt);
        View.OnClickListener onclick = new View.OnClickListener(){
            public void onClick(View view){
                getPizza(view);
            }
        };
        pizzaButton.setOnClickListener(onclick);

        //pizza shop button
        Button shopButton = findViewById(R.id.pizzaShopButt);
        View.OnClickListener onclickshop = new View.OnClickListener(){
            public void onClick(View view){
                showPizzaShop(view);
            }
        };
        shopButton.setOnClickListener(onclickshop);
    }

    public void getPizza(View view) {
        String pizza = "Your ";
        Boolean glutenFree;

        ToggleButton toggle = findViewById(R.id.sauceToggle);
        EditText pizzaInput = findViewById(R.id.namePizza);

        CheckBox onion = findViewById(R.id.onionCheck);
        CheckBox mushroom = findViewById(R.id.mushroomCheck);
        CheckBox broccoli = findViewById(R.id.broccoliCheck);
        CheckBox pepper = findViewById(R.id.pepperCheck);

        Switch gf = findViewById(R.id.gfSwitch);

        if(pizzaInput.getText().toString().matches("")) {
            Context context = getApplicationContext();
            CharSequence text = "name your pizza!";
            int duration = Toast.LENGTH_LONG;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }

        else if (!onion.isChecked() && !mushroom.isChecked() && !broccoli.isChecked() && !pepper.isChecked()) {
            Context context = getApplicationContext();
            CharSequence text = "put something on your pizza!";
            int duration = Toast.LENGTH_LONG;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }

        else {
            pizza += pizzaInput.getText().toString() + " pizza is a ";

            if (!toggle.isChecked()) {
                pizza += "white sauce pizza ";
            }
            else {
                pizza += "red sauce pizza ";
            }

            if (gf.isChecked()) {
                pizza += "on gluten-free crust with ";
                glutenFree = true;
            } else {
                pizza += "on regular crust with ";
                glutenFree = false;
            }

            if (onion.isChecked()) {
                pizza += "onions ";
            }
            if (mushroom.isChecked()) {
                pizza += "mushrooms ";
            }
            if (broccoli.isChecked()) {
                pizza += "broccoli ";
            }
            if (pepper.isChecked()) {
                pizza += "peppers ";
            }


            userPizza.setPizzaInfo(pizza, glutenFree);

            TextView displayPizza = findViewById(R.id.pizzaText);
            displayPizza.setText(userPizza.getPizza());
        }
    }

    public void showPizzaShop(View view) {

        if(userPizza.getPizzaShop().matches("")) {
            Context context = getApplicationContext();
            CharSequence text = "please create a pizza first!";
            int duration = Toast.LENGTH_LONG;

            Toast toast = Toast.makeText(context, text, duration);
            toast.show();
        }

        else {
            getPizza(view);

            Intent intent = new Intent(this, RecievePizzaShop.class);

            intent.putExtra("pizzaShop", userPizza.getPizzaShop());

            startActivity(intent);
        }
    }
}
