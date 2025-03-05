SET JAVA_HOME = "C:\Program Files\Java\jdk-21\bin"
SET PATH=%JAVA_HOME%;%PATH%
SET CLASSPATH=%JAVA_HOME%;
   SET JFLEX_HOME= C:\Users\david\OneDrive\Desktop\Recursos\jflex-1.9.1\lib
cd C:\Users\david\AndroidStudioProjects\Practica001\app\src\main\java\com\zafkiel\practica001\analizadores
java -jar %JFLEX_HOME%\jflex-full-1.9.1.jar A_Lexico.jflex
pause