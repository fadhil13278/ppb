package com.example.menumakanan;
import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;


import java.util.ArrayList;

class MenuAdapter extends RecyclerView.Adapter<MenuAdapter.ViewHolder> {

    Context context;


    public MenuAdapter(ArrayList<Makanan> listMakanan, Context context) {
        this.listMakanan = listMakanan;
        this.context = context;
    }

    private ArrayList<Makanan> listMakanan;

    @NonNull
    @Override
    public MenuAdapter.ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        Context context = parent.getContext();
        LayoutInflater inflater = LayoutInflater.from(context);
        ViewHolder holder = new ViewHolder(inflater.inflate(R.layout.item_makanan, parent, false));

        return holder;
    }

    @Override
    public void onBindViewHolder(@NonNull MenuAdapter.ViewHolder holder, int position) {
        Makanan makanan = listMakanan.get(position);
        holder.txtnama.setText(makanan.getNama());
        holder.txtharga.setText(makanan.getHarga());
        holder.imgfoto.setImageResource(makanan.getId_gambar());

        holder.itemView.setOnClickListener(new View.OnClickListener() {

            @Override
            public void onClick(View view) {
                Intent intent = new Intent(view.getContext(), int_makanan.class);
                intent.putExtra("gambar", makanan.getId_gambar());
                intent.putExtra("nama", makanan.getNama());
                intent.putExtra("deskripsi", makanan.getDeskripsi());
                intent.putExtra("harga", makanan.getHarga());
                context.startActivity(intent);

            }
        });
    }

    @Override
    public int getItemCount() {
        return listMakanan.size();
    }

    public class ViewHolder extends RecyclerView.ViewHolder {

        public TextView txtnama,txtharga,txtdeskripsi;
        public ImageView imgfoto;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);

            txtnama = (TextView) itemView.findViewById(R.id.txtnama);
            txtharga = (TextView) itemView.findViewById(R.id.txtharga);
            imgfoto = (ImageView) itemView.findViewById(R.id.imgfoto);
        }
    }
}
