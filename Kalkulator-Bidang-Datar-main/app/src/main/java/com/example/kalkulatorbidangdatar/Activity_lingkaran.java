package com.example.kalkulatorbidangdatar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class Activity_lingkaran extends AppCompatActivity {

    private EditText rtext;
    private EditText hasil;
    private Button luas;
    private Button keliling;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_lingkaran);
        rtext = (EditText) findViewById(R.id.rtext);
        hasil = (EditText) findViewById(R.id.hasil);
        luas = (Button) findViewById(R.id.luas);
        keliling = (Button) findViewById(R.id.keliling);
    }

    public void luasling (View view){
        try{

            int r = Integer.parseInt(rtext.getText().toString());
            double phi = 3.14;
            double luas = phi * r * r;
            hasil.setText(String.valueOf(luas));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void kelilingling (View view){
        try{

            int r = Integer.parseInt(rtext.getText().toString());
            double phi = 3.14;
            double keliling = 2 * phi * r;
            hasil.setText(String.valueOf(keliling));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}