package com.example.biodata

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
    }

    fun cellphone(view: View?) {
        val uri = Uri.parse("tel:082223333650")
        val it = Intent(Intent.ACTION_VIEW, uri)
        startActivity(it)
    }

    fun showMap(view: View?) {
        val uri = Uri.parse("geo:-6.9899947,110.4589498=")
        val it = Intent(Intent.ACTION_VIEW, uri)
        startActivity(it)
    }

    fun email(view: View?) {
        val intent = Intent(Intent.ACTION_SEND)
        intent.type = "text/plain"
        intent.putExtra(Intent.EXTRA_EMAIL, arrayOf("111202113278@mhs.dinus.ac.id"))
        intent.putExtra(Intent.EXTRA_SUBJECT, "Email dari Aplikasi Android")
        try {
            startActivity(Intent.createChooser(intent, "Ingin Mengirim Email ?"))
        } catch (ex: ActivityNotFoundException) {
        }
    }
}