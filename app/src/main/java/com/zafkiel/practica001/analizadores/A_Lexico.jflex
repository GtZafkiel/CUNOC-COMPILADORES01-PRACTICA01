package com.zafkiel.practica001.analizadores;
import java_cup.runtime.*;
import java.util.List;
import java.util.ArrayList;
%%
%public
%class Analizador_Lexico
%cupsym Simbolo
%cup
%{
    private int counter;
    private int counter2;
    private static List<String> lexicos = new ArrayList<>();
    public static List<String> getLexicos() {
        return lexicos;
    }
    private static List<String> erroresLexicos = new ArrayList<>();
    public static List<String> getErroresLexicos() {
        return erroresLexicos;
    }
    private static List<String> errores = new ArrayList<>();
    public static List<String> getErrores() {
        return errores;
    }
%}
%ignorecase
%init{
    counter = 0;
    counter2 = 0;
    yyline = 1;
    yycolumn = 1;
    yychar = 1;
%init}
%eof{
%eof}
%line
%column
%char
%full
    LineTerminator = \r|\n|\r\n
    InputCharacter = [^\r\n]
    HEADER = "#" {1,6} " " {InputCharacter}* {LineTerminator}?
    LISTA_ORDENADA = {DIGITO}+ "." " " {InputCharacter}* {LineTerminator}?
    LISTA_NO_ORDENADA = "\+" " " {InputCharacter}* {LineTerminator}?
    TEXTO_ITALICA = "\*" [^*\r\n]+ "\*"
    TEXTO_NEGRITA = "\*\*" [^*\r\n]+ "\*\*"
    TEXTO_NEGRITA_ITALICA = "\*\*\*" [^*\r\n]+ "\*\*\*"
    FORMAT = "format" "\(" [^"\)"]+ "\)"
    PLOT = "plot" "\(" [^"\)"]+ "\)"
    NUMERAL = "#"
    Espacios = " "
    SaltoDeLinea = \n|\r|\r\n
    DIGITO = [0-9]
    ENTERO = {DIGITO}+
    DECIMAL = {DIGITO}+(\.{DIGITO}+)?
    PRINT = "PRINT"
    PLOT = "PLOT"
    REPORTESOPERADORES = "REPORTES.OPERADORES()"
    REPORTESERRORES = "REPORTES.ERRORES()"
    IGUAL = "="
    PUNTO = "."
    MAS = "+"
    MENOS = "-"
    POR = "*"
    DIV = "/"
    POTENCIA = "^"
    PARA = "("
    PARB = ")"
    COMA = ","
    CADENA = [\"]([^\"])*[\"]
    CARACTER = [A-Za-z]
    IDENTIFICADOR = [a-zA-Z_][a-zA-Z_0-9]*
%%
<YYINITIAL> {Espacios} {
}
<YYINITIAL> {HEADER} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: INSTRUCCION HEADER.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.HEADER, yycolumn, yyline, yytext());
}
<YYINITIAL> {TEXTO_ITALICA} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: INSTRUCCION TEXTO EN ITALICA.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.TEXTO_ITALICA, yycolumn, yyline, yytext());
}
<YYINITIAL> {TEXTO_NEGRITA} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: INSTRUCCION TEXTO EN NEGRITA.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.TEXTO_NEGRITA, yycolumn, yyline, yytext());
}
<YYINITIAL> {TEXTO_NEGRITA_ITALICA} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: INSTRUCCION TEXTO EN NEGRITA E ITALICA.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.TEXTO_NEGRITA_ITALICA, yycolumn, yyline, yytext());
}
<YYINITIAL> {LISTA_ORDENADA} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: INSTRUCCION TEXTO LISTA ORDENADA.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.LISTA_ORDENADA, yycolumn, yyline, yytext());
}
<YYINITIAL> {LISTA_NO_ORDENADA} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: INSTRUCCION TEXTO EN LISTA NO ORDENADA.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.LISTA_NO_ORDENADA, yycolumn, yyline, yytext());
}
<YYINITIAL> {PRINT} {
    counter++;
    lexicos.add("---> Contador: "+counter+"          Token: "+yytext()+"          Tipo: PALABRA RESERVADA.          Línea: "+yyline+"          Columna: "+yycolumn+"\n");
    return new Symbol(Simbolo.PRINT, yycolumn, yyline, yytext());
}
<YYINITIAL> {FORMAT} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: INSTRUCCION FORMAT"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.FORMAT, yycolumn, yyline, yytext());
}
<YYINITIAL> {PLOT} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: INSTRUCCION PLOT"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.PLOT, yycolumn, yyline, yytext());
}
<YYINITIAL> {PLOT} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: INSTRUCCION PLOT"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.PLOT, yycolumn, yyline, yytext());
}
<YYINITIAL> {REPORTESOPERADORES} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: REPORTES OPERADORES"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.REPORTESOPERADORES, yycolumn, yyline, yytext());
}
<YYINITIAL> {REPORTESERRORES} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: REPORTES ERRORES"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.REPORTEERRORES, yycolumn, yyline, yytext());
}
<YYINITIAL> {CADENA} {
    counter++;
    String cadena = yytext();
    cadena = cadena.substring(1, cadena.length()-1);
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+cadena+"          Tipo: CADENA"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.CADENA, yycolumn, yyline, cadena);
}
<YYINITIAL> {CARACTER} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: CARACTER"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.CARACTER, yycolumn, yyline, yytext());
}
<YYINITIAL> {IGUAL} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: IGUAL"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.IGUAL, yycolumn, yyline, yytext());
}
<YYINITIAL> {PUNTO} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: PUNTO"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.PUNTO, yycolumn, yyline, yytext());
}
<YYINITIAL> {POTENCIA} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: POTENCIA"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.POTENCIA, yycolumn, yyline, yytext());
}
<YYINITIAL> {COMA} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: COMA"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.COMA, yycolumn, yyline, yytext());
}
<YYINITIAL> {NUMERAL} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: NUMERAL"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.NUMERAL, yycolumn, yyline, yytext());
}
<YYINITIAL> {MAS} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: SUMA"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.MAS, yycolumn, yyline, yytext());
}
<YYINITIAL> {MENOS} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: RESTA"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.MENOS, yycolumn, yyline, yytext());
}
<YYINITIAL> {POR} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: MULTIPLICACION"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.POR, yycolumn, yyline, yytext());
}
<YYINITIAL> {DIV} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: DIVICION"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.DIV, yycolumn, yyline, yytext());
}
<YYINITIAL> {POTENCIA} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: POTENCIA"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.POTENCIA, yycolumn, yyline, yytext());
}
<YYINITIAL> {PARA} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: PARENTESIS ABIERTO"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
   return new Symbol(Simbolo.PARA, yycolumn, yyline, yytext());
}
<YYINITIAL> {PARB} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: PARENTESIS CERRADO"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.PARB, yycolumn, yyline, yytext());
}
<YYINITIAL> {ENTERO} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: ENTERO"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.ENTERO, yycolumn, yyline, yytext());
}
<YYINITIAL> {DECIMAL} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: DECIMAL"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.DECIMAL, yycolumn, yyline, yytext());
}
<YYINITIAL> {IDENTIFICADOR} {
    counter++;
    lexicos.add( "--->   Contador: "+counter+ "          Token: "+yytext()+"          Tipo: IDENTIFICADOR"+".         Linea: " +yyline +"          Columna: "+yycolumn+"          Caracter: "+yychar+"\n");
    return new Symbol(Simbolo.IDENTIFICADOR, yycolumn, yyline, yytext());
}
<YYINITIAL> {SaltoDeLinea} {
}
<YYINITIAL> . {
    counter++;
    counter2++;
    lexicos.add("---->   ERROR LEXICO: " +counter2+ "                   Contador: "+counter+"                    Lexema: " + yytext() + "                   Keyword: " + "ERROR - Simbolo no existe en el lenguaje" +
                "                   Linea: " + yyline +"                   Columna: " + yycolumn + "                   Caracter: " + yychar+"\n");
    erroresLexicos.add("---->   ERROR LEXICO: " +counter2+ "                    Lexema: " + yytext() + "                   Keyword: " + "ERROR - Simbolo no existe en el lenguaje" +
                "                   Linea: " + yyline +"                   Columna: " + yycolumn + "                   Caracter: " + yychar+"\n");
    errores.add("---->   ERROR LEXICO: " +counter2+ "                    Lexema: " + yytext() + "                   Keyword: " + "ERROR - Simbolo no existe en el lenguaje" +
                "                   Linea: " + yyline +"                   Columna: " + yycolumn + "                   Caracter: " + yychar+"\n");
}