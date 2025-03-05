package com.zafkiel.practica001;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

public class ReportesArchivos extends AppCompatActivity {
    private EditText mostrarReportes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_reportes_archivos);

        mostrarReportes = findViewById(R.id.mostrarReportes);


        if (CarcaArchivos.contenidoAnalizado != "") {
            mostrarReportes.setText(CarcaArchivos.contenidoAnalizado);
        } else {
            mostrarReportes.setText("No hay datos disponibles.");
        }

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }

    public void botonInicio3(View v){
        Intent intento = new Intent(this, CarcaArchivos.class);
        startActivity(intento);
    }
    public void botonSalida3(View v){
        Intent intento = new Intent(this, VisualizacionArchivos.class);
        startActivity(intento);
    }
    public void botonReportes3(View v){
    }
    public void botonSalir3(View v){
        Intent intento = new Intent(this, MainActivity.class);
        startActivity(intento);

    }
}