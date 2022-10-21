package com.example.menumakanan;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.widget.ImageView;
import android.widget.TextView;

public class int_makanan extends AppCompatActivity {

    TextView txtnama, txtharga, txtdeskripsi;
    ImageView imgfoto;
    String nama, harga, deskripsi;
    Integer gambar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_int_makanan);

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        setTitle("Detail Makanan: ");

        nama = getIntent().getStringExtra("nama");
        harga = getIntent().getStringExtra("harga");
        deskripsi = getIntent().getStringExtra("deskripsi");

        setTitle("Detail Makanan: "+nama);
        imgfoto = findViewById(R.id.imgfoto);
        imgfoto.setImageResource(getIntent().getIntExtra("gambar",0));
        txtnama = findViewById(R.id.txtnama); txtnama.setText(nama);
        txtharga = findViewById(R.id.txtharga); txtharga.setText("Harga:" + harga);
        txtdeskripsi = findViewById(R.id.txtdeskripsi); txtdeskripsi.setText(deskripsi);
    }
}
