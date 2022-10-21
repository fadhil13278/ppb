package com.example.kalkulatorbidangdatar;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        Button Lingkaran = (Button) findViewById(R.id.lingkaran);
        Lingkaran.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent lingkaran = new Intent(MainActivity.this, Activity_lingkaran.class);
                startActivity(lingkaran);
            }
        });

        Button Segitiga = (Button) findViewById(R.id.segitiga);
        Segitiga.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent segitiga = new Intent(MainActivity.this, Activity_segitiga.class);
                startActivity(segitiga);
            }
        });

        Button Persegi = (Button) findViewById(R.id.persegi);
        Persegi.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent persegi = new Intent(MainActivity.this, Activity_persegi.class);
                startActivity(persegi);
            }
        });

    }
}