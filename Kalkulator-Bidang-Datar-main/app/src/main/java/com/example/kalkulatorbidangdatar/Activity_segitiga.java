package com.example.kalkulatorbidangdatar;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class Activity_segitiga extends AppCompatActivity {

    private EditText atext;
    private EditText ttext;
    private EditText btext;
    private EditText ctext;
    private EditText hasil;
    private Button keliling;
    private Button luas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_segitiga);
        atext = (EditText) findViewById(R.id.atext);
        ttext = (EditText) findViewById(R.id.ttext);
        btext = (EditText) findViewById(R.id.btext);
        ctext = (EditText) findViewById(R.id.ctext);
        hasil = (EditText) findViewById(R.id.hasil);
        luas = (Button) findViewById(R.id.luas);
        keliling = (Button) findViewById(R.id.keliling);
    }

    public void kelilingsegitiga (View view) {
        try{

            int a = Integer.parseInt(atext.getText().toString());
            int b = Integer.parseInt(btext.getText().toString());
            int c = Integer.parseInt(ctext.getText().toString());
            double keliling = a + b + c;
            hasil.setText(String.valueOf(keliling));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void luassegitiga(View view) {
        try {

            int a = Integer.parseInt(atext.getText().toString());
            int t = Integer.parseInt(ttext.getText().toString());
            double luas = (a * t)/2;
            hasil.setText(String.valueOf(luas));
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}