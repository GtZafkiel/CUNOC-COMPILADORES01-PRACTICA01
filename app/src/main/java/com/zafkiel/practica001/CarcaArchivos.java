package com.zafkiel.practica001;


import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;
import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.zafkiel.practica001.analizadores.Analizador_Lexico;
import com.zafkiel.practica001.analizadores.Analizador_Sintactico;
import com.zafkiel.practica001.analizadores.Simbolo;

import java.io.BufferedReader;
import java.io.StringReader;
import java.util.List;

import java_cup.runtime.Symbol;

public class CarcaArchivos extends AppCompatActivity {

    private EditText editTextMultiLine2;
    public static String contenidoAnalizado;
    public static String contenidoSalida;
    private static String contenidoParaAnalizar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_carca_archivos);


        editTextMultiLine2 = findViewById(R.id.editTextTextMultiLine2);

        if (CarcaArchivos.contenidoParaAnalizar != "") {
            editTextMultiLine2.setText(contenidoParaAnalizar);
        } else {
            editTextMultiLine2.setText("No hay datos disponibles.");
        }

        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);
            return insets;
        });
    }

    public void botonInicio(View v){
    }

    public void botonSalida(View v){
        Intent intento = new Intent(this, VisualizacionArchivos.class);
        startActivity(intento);
    }

    public void botonReportes(View v){
        Intent intento = new Intent(this, ReportesArchivos.class);
        startActivity(intento);
    }

    public void botonSalir(View v){
        Intent intento = new Intent(this, MainActivity.class);
        startActivity(intento);
    }

    public void botonLimpiarInicio(View v){
        editTextMultiLine2.setText("");
        contenidoAnalizado = "";
        contenidoParaAnalizar = "";
        contenidoSalida = "";
    }
    public void botonAnalizarInicio(View v){
        contenidoParaAnalizar = "";
        contenidoParaAnalizar = editTextMultiLine2.getText().toString();
        String textoIngresado = "";
        textoIngresado = editTextMultiLine2.getText().toString();
        if (!textoIngresado.isEmpty()) {
            Toast.makeText(this, "Analizando...", Toast.LENGTH_SHORT).show();
            try {
                BufferedReader buffer = new BufferedReader(new StringReader(textoIngresado));
                Analizador_Lexico lexico = new Analizador_Lexico(buffer);
                Analizador_Sintactico sintactico = new Analizador_Sintactico(lexico);
                try{
                    sintactico.parse();
                }catch (Exception ignored){

                }
                while (true) {
                    Symbol token = lexico.next_token();
                    if (token.sym == Simbolo.EOF) break;
                }
                //---> LEXICO
                List<String> tokensLexicos = Analizador_Lexico.getLexicos();
                StringBuilder resultado = new StringBuilder("- - - T O K E N S   L E X I C O S - - -\n");
                for (String token : tokensLexicos) {
                    resultado.append(token).append("\n");
                }
                tokensLexicos.clear();
                //---> SINTACTICO

                resultado.append("\n\n\n- - - I N S T R U C C I O N E S   S I N T A C T I C A S - - -\n");
                List<String> instruccionSintactica = Analizador_Sintactico.getInstruccionSintactica();
                for (String sintacticos01 : instruccionSintactica) {
                    resultado.append(sintacticos01).append("\n");
                }

                StringBuilder resultadoSalida = new StringBuilder("- - -   S A L I D A S   E S P E R A D A S   - - -\n");
                List<String> sintacticos = Analizador_Sintactico.getSintacticos();
                for (String sintacticos00 : sintacticos) {
                    resultadoSalida.append(sintacticos00).append("\n");
                }

                resultado.append("\n\n\n- - - R E P O R T E   O P E R A D O R E S - - -\n");
                List<String> sintacticos2 = Analizador_Sintactico.getSintacticos2();
                for (String sintacticos002 : sintacticos2) {
                    resultado.append(sintacticos002).append("\n");
                }

                resultado.append("\n\n\n- - - R E P O R T E   E R R O R E S   S I N T A C T I C O S- - -\n");
                List<String> sintacticosErrores = Analizador_Sintactico.getSintacticosErrores();
                for (String sintacticos003 : sintacticosErrores) {
                    resultado.append(sintacticos003).append("\n");
                }

                resultado.append("\n\n\n- - - R E P O R T E   E R R O R E S   L E X I C O S - - -\n");
                List<String> erroresLexicos = Analizador_Lexico.getErroresLexicos();
                for (String lexicos003 : erroresLexicos) {
                    resultado.append(lexicos003).append("\n");
                }

                instruccionSintactica.clear();
                sintacticos.clear();
                sintacticos2.clear();
                contenidoSalida = resultadoSalida.toString();

                contenidoAnalizado = resultado.toString();
                resultado.setLength(0);
                resultadoSalida.setLength(0);


            }catch (Exception e01){

            }

        } else {
            Toast.makeText(this, "Por favor, ingresar texto.", Toast.LENGTH_SHORT).show();
            contenidoAnalizado = "";
            contenidoSalida = "";
        }
    }

}
