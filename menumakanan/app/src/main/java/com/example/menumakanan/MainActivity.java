package com.example.menumakanan;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import android.os.Bundle;
import android.view.Menu;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity {
    private RecyclerView recMakanan;
    private ArrayList<Makanan> listMakanan;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        recMakanan = findViewById(R.id.rec_makanan);
        initData();

        recMakanan.setAdapter(new MenuAdapter(listMakanan,this));
        recMakanan.setLayoutManager(new LinearLayoutManager(this));
    }

    private void initData(){
        this.listMakanan = new ArrayList<>();
        listMakanan.add(new Makanan("Ayam Goreng",
                "Rp. 15.000",
                "Ayam goreng adalah ayam yang digoreng dalam minyak goreng dengan menggunakan bumbu khusus kemudian terdapat juga sayuran atau biasa di sebut lalapan.",
                R.drawable.ayamgoreng));

        listMakanan.add(new Makanan("Bebek Goreng",
                " Rp. 20.000",
                "Bebek goreng adalah bebek yang digoreng dalam minyak goreng dengan menggunakan bumbu khusus kemudian terdapat juga sayuran atau biasa di sebut lalapan.",
                R.drawable.bebekgoreng));

        listMakanan.add(new Makanan("Nila Goreng",
                "Rp. 13.000",
                "Nila goreng adalah nila yang digoreng dalam minyak goreng dengan menggunakan bumbu khusus kemudian terdapat juga sayuran atau biasa di sebut lalapan.",
                R.drawable.nilagoreng));

        listMakanan.add(new Makanan("Lele Goreng",
                "Rp. 10.000",
                "Lele goreng adalah lele yang digoreng dalam minyak goreng dengan menggunakan bumbu khusus kemudian terdapat juga sayuran atau biasa di sebut lalapan.",
                R.drawable.lelegoreng)) ;
    }
}