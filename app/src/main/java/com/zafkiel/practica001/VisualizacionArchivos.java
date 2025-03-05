package com.zafkiel.practica001;
import android.annotation.SuppressLint;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.graphics.drawable.BitmapDrawable;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;
import androidx.appcompat.app.AppCompatActivity;
import io.noties.markwon.Markwon;
import ru.noties.jlatexmath.JLatexMathDrawable;

import org.scilab.forge.jlatexmath.TeXFormula;




public class VisualizacionArchivos extends AppCompatActivity {

    private LinearLayout layoutSalidas;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_visualizacion_archivos);

        layoutSalidas = findViewById(R.id.layoutSalidas);

        String contenidoSalida = CarcaArchivos.contenidoSalida;

        if (!contenidoSalida.isEmpty()) {
            mostrarTextoPorLineas(contenidoSalida);
        } else {
            agregarLineaTextoPlano("No hay datos disponibles.");
        }
    }

    private void mostrarTextoPorLineas(String texto) {
        Markwon markwon = Markwon.create(this);
        String[] lineas = texto.split("\n");

        for (String linea : lineas) {
            if (esLatex(linea)) {
                agregarLineaJLatex(linea);
            } else if (esMarkdown(linea)) {
                agregarLineaMarkdown(linea, markwon);
            } else {
                agregarLineaTextoPlano(linea);
            }
        }
    }

    private boolean esLatex(String texto) {
        return texto.startsWith("format(") && texto.endsWith(")");
    }

    private boolean esMarkdown(String texto) {
        return texto.startsWith("#") || texto.startsWith("**") || texto.startsWith("***") ||
                texto.startsWith("*") || texto.startsWith("+ ") || texto.contains("__") || texto.contains("~~") ||
                texto.matches(".*\\*[^\\*]+\\*.*");
    }

    private void agregarLineaMarkdown(String texto, Markwon markwon) {
        TextView textView = new TextView(this);
        textView.setTextSize(18);
        markwon.setMarkdown(textView, texto);
        layoutSalidas.addView(textView);
    }

    private void agregarLineaTextoPlano(String texto) {
        TextView textView = new TextView(this);
        textView.setTextSize(18);
        textView.setText(texto);
        layoutSalidas.addView(textView);
    }


    private void agregarLineaJLatex(String texto) {
        agregarLineaTextoPlano("Error en la expresión LaTeX: " + texto);
        String latexExpresion = texto.substring(7, texto.length() - 1).trim();

        try {

            if (latexExpresion.matches("\\d+(\\.\\d+)?")) {
                latexExpresion = "$" + latexExpresion + "$"; // Envolver en $
            } else {
                // Reemplazar potencias (x^2 → x^{2}) y divisiones
                latexExpresion = latexExpresion.replace("^", "^{").replace("+", " + ").replace("-", " - ");
                latexExpresion = latexExpresion.replace("*", " \\times ").replace("/", "\\frac");

                // Asegurar que los exponentes cierren correctamente
                int count = latexExpresion.length() - latexExpresion.replace("{", "").length();
                int count2 = latexExpresion.length() - latexExpresion.replace("}", "").length();
                while (count > count2) {
                    latexExpresion += "}";
                    count2++;
                }

                // Agregar `$` al inicio y final para formato correcto en LaTeX
                latexExpresion = "$" + latexExpresion + "$";
            }

            // Crear la fórmula LaTeX
            TeXFormula formula = new TeXFormula(latexExpresion);

            // Construir el JLatexMathDrawable correctamente con su Builder
            JLatexMathDrawable drawable = JLatexMathDrawable.builder(formula.toString())
                    .textSize(50)
                    .align(JLatexMathDrawable.ALIGN_CENTER)
                    .padding(10)
                    .build();

            ImageView imageView = new ImageView(this);
            imageView.setImageDrawable(drawable);
            layoutSalidas.addView(imageView);
        } catch (Exception e) {
            agregarLineaTextoPlano("Error en la expresión LaTeX: " + latexExpresion);
        }
    }






    public void botonInicio2(View v) {
        Intent intento = new Intent(this, CarcaArchivos.class);
        startActivity(intento);
    }

    public void botonSalida2(View v) {}

    public void botonReportes2(View v) {
        Intent intento = new Intent(this, ReportesArchivos.class);
        startActivity(intento);
    }

    public void botonSalir2(View v) {
        Intent intento = new Intent(this, MainActivity.class);
        startActivity(intento);
    }
}
