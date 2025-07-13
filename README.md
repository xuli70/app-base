# ? App Base

Aplicaci?n base ultra-minimalista para iniciar nuevos proyectos con Coolify.

## ? Caracter?sticas

- ? **HTML m?nimo funcional** con dise?o moderno
- ? **Dockerfile v1.0.3** probado y funcionando
- ? **Configuraci?n ultra-simple** de Caddy
- ? **Health check** incluido
- ? **Puerto 8080** configurado
- ? **UTF-8 COMPLETO** para caracteres espa?oles
- ? **Soporte garantizado** para: ?, tildes (?????), di?resis (??), s?mbolos (????)

## ?? Soporte para Espa?ol

Esta aplicaci?n base est? **especialmente configurada** para el desarrollo en espa?ol:

- **Variables de entorno**: `LANG=C.UTF-8`, `LC_ALL=C.UTF-8`
- **Headers HTTP**: `Content-Type: text/html; charset=utf-8`
- **Configuraci?n Caddy**: UTF-8 para HTML, CSS, JS
- **Prueba incluida**: Ma?ana ser? un d?a estupendo para programar en espa?ol ??

## ? Uso

1. **Fork o copia este repositorio**
2. **Modifica `index.html`** con tu contenido
3. **Push a GitHub**
4. **Deploy en Coolify** con Build Pack: Dockerfile

## ? Estructura

```
app-base/
??? index.html      # Tu aplicaci?n aqu? (con prueba de caracteres espa?oles)
??? Dockerfile      # Configuraci?n para Coolify (v1.0.3 con UTF-8)
??? README.md       # Este archivo
??? .gitignore      # Archivos a ignorar
```

## ? Configuraci?n para Coolify

- **Puerto**: 8080 (obligatorio para Coolify)
- **Server**: Caddy
- **Build Pack**: Dockerfile
- **Charset**: UTF-8 autom?tico
- **Headers de seguridad**: Coolify los maneja autom?ticamente

## ?? Para comenzar

Simplemente edita `index.html` y comienza a desarrollar tu aplicaci?n. 

**Ejemplo de uso con caracteres espa?oles:**
```html
<h1>?Hola! Bienvenido a mi aplicaci?n</h1>
<p>Esta aplicaci?n funciona perfectamente con ?, tildes y s?mbolos especiales.</p>
<p>Ma?ana ser? un d?a estupendo para programar en espa?ol ??</p>
```

## ? Deploy en Coolify

1. **Crea nueva aplicaci?n** en Coolify
2. **Conecta este repositorio**: `https://github.com/tu-usuario/app-base`
3. **Selecciona Build Pack**: Dockerfile
4. **Deploy autom?tico** - ?Ya est?!

## ? Pruebas de caracteres

La aplicaci?n incluye una secci?n de pruebas para verificar que todos los caracteres espa?oles se muestran correctamente:

- **Vocales con tilde**: ????? ?????
- **?**: ??  
- **S?mbolos**: ?? ?? ??
- **Emojis**: ?? ? ?

## ? Tecnolog?as

- **Base**: Node.js 18 Alpine
- **Server**: Caddy 2.8+
- **Encoding**: UTF-8
- **Platform**: Coolify
- **Health check**: Wget

---

**Creado por:** xuli70  
**Versi?n:** 1.0.3  
**Base probada:** Julio 2025  
**Soporte UTF-8:** Completo para espa?ol