# ? PROMPT TEMPLATE - App Base Coolify

**Usa este prompt para crear nuevas aplicaciones basadas en nuestra configuraci&oacute;n probada en producci&oacute;n**

---

## ? PROMPT PARA NUEVAS APLICACIONES

```
Necesito crear una nueva aplicaci&oacute;n web que se despliegue autom&aacute;ticamente desde GitHub a mi VPS usando Coolify.

### ? REQUISITOS OBLIGATORIOS:

1. **Usar como base:** El repositorio https://github.com/xuli70/app-base (versi&oacute;n 1.0.3 probada en producci&oacute;n)

2. **Configuraci&oacute;n Docker obligatoria:**
   - Puerto 8080 (requerido por Coolify)
   - Servidor Caddy (mejor compatibilidad que nginx)
   - Health check con wget incluido
   - Variables de entorno UTF-8 configuradas

3. **Dockerfile exacto a usar como plantilla:**
```dockerfile
FROM node:18-alpine

LABEL maintainer="xuli70"
LABEL description="[DESCRIPCION_DE_TU_APP]"
LABEL version="1.0.0"

# Configurar localizaci&oacute;n y UTF-8 para caracteres espa&ntilde;oles
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANGUAGE=C.UTF-8

WORKDIR /app
RUN apk add --no-cache caddy
COPY . .

# Caddyfile ULTRA-SIMPLE (NO usar bloques de headers)
RUN echo -e ":${PORT:-8080} {\n\
    root * /app\n\
    file_server\n\
    try_files {path} /index.html\n\
    encode gzip\n\
    header Content-Type text/html; charset=utf-8\n\
    log {\n\
        output stdout\n\
        format console\n\
    }\n\
}" > /app/Caddyfile

EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

CMD ["caddy", "run", "--config", "/app/Caddyfile", "--adapter", "caddyfile"]
```

### ?? ERRORES CR&Iacute;TICOS QUE DEBES EVITAR:

1. **NO usar headers en bloques** en Caddyfile:
   ```dockerfile
   # ? INCORRECTO - Causa error
   header / {
       Content-Type "text/html; charset=utf-8"
   }
   
   # ? CORRECTO - Header directo
   header Content-Type text/html; charset=utf-8
   ```

2. **NO confiar solo en UTF-8 meta tags** para caracteres espa&ntilde;oles:
   ```html
   <!-- ? NO es suficiente -->
   <meta charset="UTF-8">
   
   <!-- ? USAR entidades HTML -->
   <title>Mi App - &ntilde; Espa&ntilde;ol</title>
   <p>Aplicaci&oacute;n con &aacute;cento</p>
   ```

### ? ESTRUCTURA DE ARCHIVOS OBLIGATORIA:

```
mi-nueva-app/
??? index.html          # P&aacute;gina principal (usar entidades HTML)
??? Dockerfile          # Configuraci&oacute;n exacta de arriba
??? README.md           # Documentaci&oacute;n b&aacute;sica
??? .gitignore          # Ignorar logs, node_modules, etc.
??? [otros archivos]    # Tu aplicaci&oacute;n espec&iacute;fica
```

### ? CONFIGURACI&Oacute;N HTML BASE:

```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>[TU_TITULO] - &ntilde; Espa&ntilde;ol</title>
</head>
<body>
    <!-- Tu contenido aqu&iacute; -->
    <!-- Usar entidades HTML: &ntilde; &aacute; &eacute; &iacute; &oacute; &uacute; -->
    <!-- Signos: &iquest; &iexcl; -->
</body>
</html>
```

### ? CHECKLIST PRE-DEPLOYMENT:

- [ ] Dockerfile sigue la plantilla exacta
- [ ] Puerto 8080 configurado
- [ ] Health check incluido
- [ ] Caracteres espa&ntilde;oles como entidades HTML
- [ ] No hay headers en bloques en Caddyfile
- [ ] Build local exitoso: `docker build -t test-app .`
- [ ] Test local funciona: `docker run -p 8080:8080 test-app`

### ? DEPLOYMENT EN COOLIFY:

1. **GitHub:** Push c&oacute;digo al repositorio
2. **Coolify:** Crear nueva aplicaci&oacute;n
3. **Build Pack:** Dockerfile
4. **Puerto:** 8080 (autom&aacute;tico)
5. **Deploy:** Verificar que no hay errores de Caddyfile

### ? REFERENCIAS:

- Repositorio base: https://github.com/xuli70/app-base
- Troubleshooting: Ver TROUBLESHOOTING.md en el repo
- Test UTF-8: Ver test-spanish.html para ejemplos
- Entidades HTML: https://www.w3schools.com/html/html_entities.asp

[AQU&Iacute; ESPECIFICA TU APLICACI&Oacute;N ESPEC&Iacute;FICA]
```

---

## ? C&Oacute;MO USAR ESTE PROMPT

### 1. **Copia el prompt completo** desde "Necesito crear una nueva aplicaci&oacute;n..." hasta "[AQU&Iacute; ESPECIFICA...]"

### 2. **Personaliza la secci&oacute;n final** con:
- Descripci&oacute;n de tu aplicaci&oacute;n espec&iacute;fica
- Tecnolog&iacute;as adicionales necesarias (React, Vue, etc.)
- Funcionalidades espec&iacute;ficas
- Requisitos de dise&ntilde;o o UX

### 3. **Ejemplo de personalizaci&oacute;n:**
```
[AQU&Iacute; ESPECIFICA TU APLICACI&Oacute;N ESPEC&Iacute;FICA]

La aplicaci&oacute;n es un dashboard administrativo con las siguientes caracter&iacute;sticas:
- Frontend: HTML + TailwindCSS + JavaScript vanilla
- Funcionalidades: Login, CRUD de usuarios, reportes
- Dise&ntilde;o: Moderno, responsive, tema oscuro/claro
- Integraci&oacute;n: APIs REST, localStorage para sesi&oacute;n
- P&aacute;ginas: /login, /dashboard, /users, /reports

Mant&eacute;n la estructura simple y enf&oacute;cate en la funcionalidad core.
Aseg&oacute;rate de que todo funcione perfectamente en m&oacute;vil.
```

### 4. **Pega el prompt completo** en tu herramienta de IA preferida

---

## ? LISTA DE ENTIDADES HTML COMUNES

```html
<!-- Caracteres b&aacute;sicos -->
&ntilde; &Ntilde;           <!-- ? ? -->
&aacute; &eacute; &iacute; &oacute; &uacute;   <!-- ? ? ? ? ? -->
&Aacute; &Eacute; &Iacute; &Oacute; &Uacute;   <!-- ? ? ? ? ? -->

<!-- Signos -->
&iquest; &iexcl;            <!-- ? ? -->
&uuml; &Uuml;              <!-- ? ? -->

<!-- S&iacute;mbolos -->
&euro; &copy; &reg;         <!-- ? ? ? -->
```

---

**? Este prompt est&aacute; probado en producci&oacute;n con Coolify desde Julio 2025**  
**? Garantiza deployment exitoso sin errores de headers o UTF-8**  
**? Actualizado con todas las lecciones aprendidas del desarrollo real**