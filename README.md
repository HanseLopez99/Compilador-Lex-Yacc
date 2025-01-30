
# Compilador con Lex y Yacc  
Este proyecto implementa la fase inicial de un compilador utilizando **Lex y Yacc**, permitiendo el análisis léxico y sintáctico de expresiones matemáticas y asignaciones de variables.  

## 🚀 Instrucciones de Uso  
Puedes ejecutar el compilador de dos maneras:  
1. **Usando herramientas locales** (Lex, Yacc y GCC).  
2. **Usando Docker** (para evitar instalaciones manuales).  

## 🔹 Instalación Local  
Para compilar y ejecutar el analizador en una máquina con `Lex`, `Yacc` y `GCC` instalados:  
```sh
flex ./files/simple_language.l
yacc -dtv ./files/simple_language.y
g++ -c lex.yy.c 
g++ -c y.tab.c
g++ -o calc y.tab.o lex.yy.o
./calc

```

## Uso con Docker 
Si prefieres no instalar herramientas manualmente, puedes usar Docker siguiendo estos pasos:

1. Construye la imagen de Docker:  

```sh
docker build –rm . -t lab1-image
```

2. Ejecuta el contenedor:  

```sh
docker run --rm -it lab1-image
```

Esto generará un contenedor interactivo donde podrás ejecutar el compilador de la misma manera que en una instalación local.

## Características del Compilador  
- Reconoce variables y expresiones matemáticas.  
- Soporta operaciones aritméticas (`+`, `-`, `*`, `/`) con precedencia correcta.  
- Manejo de errores para tokens inválidos y variables no declaradas.  
- Se puede ejecutar tanto en Linux/macOS como en Windows con WSL2 o Docker.  

## Ejemplo de Uso  
Una vez ejecutado el compilador (`./calc`), puedes ingresar expresiones como:  

a = 3 + 4 * 2:
Assign a = 11

b = (3 + 4) * 2:
Assign b = 14

c = 10 - 2 / 2:
Assign c = 9

d = (10 - 2) / 2:
Assign d = 4

El compilador respeta la precedencia matemática estándar:
- Multiplicación y división (`* /`) tienen mayor prioridad que suma y resta (`+ -`).
- Se pueden usar paréntesis para forzar un orden de evaluación específico.

## Manejo de Errores  
El compilador incluye validaciones para:  
1. **Tokens inválidos**: Muestra un mensaje de error si se ingresa un carácter desconocido.  
2. **Variables no declaradas**: Previene el uso de variables sin asignación previa.  
3. **Errores de sintaxis**: Recupera la ejecución cuando se detectan entradas incorrectas.  

Ejemplo de error detectado:  

x + 5:
Error semántico: Variable ‘x’ no declarada.