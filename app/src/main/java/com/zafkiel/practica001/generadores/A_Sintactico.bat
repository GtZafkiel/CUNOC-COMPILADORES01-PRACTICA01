SET JAVA_HOME = "C:\Program Files\Java\jdk-21\bin"
SET PATH=%JAVA_HOME%;%PATH%
SET CLASSPATH=%JAVA_HOME%;
SET CUP_HOME= C:\Users\david\OneDrive\Desktop\Recursos\java-cup-11b.jar
cd C:\Users\david\AndroidStudioProjects\Practica001\app\src\main\java\com\zafkiel\practica001\analizadores
java -jar %CUP_HOME% -parser Analizador_Sintactico -symbols Simbolo A_Sintactico.cup
pause