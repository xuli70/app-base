# ? TROUBLESHOOTING - App Base

## Errores Cr?ticos Resueltos en Producci?n (Julio 2025)

Esta documentaci?n contiene los **errores m?s cr?ticos** encontrados durante el desarrollo y deployment real en Coolify, junto con sus soluciones definitivas.

---

## ? ERROR CR?TICO #1: Headers Duplicados en Caddyfile

### S?ntomas
```
Error: adapting config using caddyfile: parsing caddyfile tokens for 'header': 
cannot specify headers in both arguments and block, at /app/Caddyfile:12
```

### Causa Ra?z
Caddy no permite usar headers tanto en formato de argumentos como en bloques `{}` simult?neamente.

### ? C?digo que CAUSA el error:
```dockerfile
RUN echo -e ":${PORT:-8080} {\n\
    root * /app\n\
    file_server\n\
    try_files {path} /index.html\n\
    encode gzip\n\
    header / {\n\
        Content-Type \"text/html; charset=utf-8\"\n\
    }\n\
    log {\n\
        output stdout\n\
        format console\n\
    }\n\
}" > /app/Caddyfile
```

### ? Soluci?n CORRECTA:
```dockerfile
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
```

### Lecci?n Aprendida
- **Header directo:** `header Content-Type text/html; charset=utf-8`
- **NO usar bloques:** Evitar `header / { ... }`
- **Coolify maneja autom?ticamente** headers de seguridad via reverse proxy

---

## ? ERROR CR?TICO #2: Caracteres Espa?oles Corruptos

### S?ntomas
- Caracteres `?` aparecen como `?`
- Tildes `? ? ? ? ?` se ven como `?`
- Signos `? ?` no funcionan
- Todo el texto espa?ol se corrompe

### Ejemplos de corrupci?n:
```
? App Base - ? Espa?ol
? Aplicaci?n base 
? ?C?mo est? usted?
```

### Causa Ra?z Investigada
1. **Archivo HTML se corrompe** durante el proceso de upload a GitHub
2. **Meta charset="UTF-8"** no es suficiente 
3. **Variables de entorno** LANG, LC_ALL no resuelven el problema
4. **Headers Content-Type** en Caddyfile tampoco funcionan solos

### ? Soluciones que NO funcionaron:
```html
<!-- NO es suficiente -->
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
```

```dockerfile
# NO funciona solo
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
```

```dockerfile
# NO es suficiente
header Content-Type text/html; charset=utf-8
```

### ? SOLUCI?N DEFINITIVA: Entidades HTML
```html
<!-- Caracteres seguros que SIEMPRE funcionan -->
<title>App Base - &ntilde; Espa&ntilde;ol</title>
<p>Aplicaci&oacute;n base lista para desarrollo</p>
<p>&iquest;C&oacute;mo est&aacute; usted? &iexcl;Excelente!</p>
```

### Tabla de Entidades HTML Espa?olas
| Car?cter | Entidad HTML | Uso |
|----------|--------------|-----|
| ? | `&ntilde;` | Espa?a, ni?o |
| ? | `&Ntilde;` | ESPA?A |
| ? | `&aacute;` | caf?, f?cil |
| ? | `&eacute;` | Jos? |
| ? | `&iacute;` | dif?cil |
| ? | `&oacute;` | coraz?n |
| ? | `&uacute;` | ?nico |
| ? | `&Aacute;` | ?NGEL |
| ? | `&Eacute;` | JOS? |
| ? | `&Iacute;` | MAR?A |
| ? | `&Oacute;` | RAM?N |
| ? | `&Uacute;` | ?NICO |
| ? | `&iquest;` | ?C?mo? |
| ? | `&iexcl;` | ?Hola! |
| ? | `&uuml;` | verg?enza |
| ? | `&Uuml;` | VERG?ENZA |

---

## ? Checklist de Deployment Exitoso

### ? Antes del Deploy
- [ ] Dockerfile sin headers en bloques `{}`
- [ ] Puerto 8080 configurado
- [ ] Caracteres espa?oles como entidades HTML
- [ ] Health check con wget incluido

### ? Durante el Deploy
- [ ] Build exitoso sin errores de Caddyfile
- [ ] Health check pasa correctamente
- [ ] Logs muestran "using config from file"

### ? Despu?s del Deploy
- [ ] P?gina carga correctamente
- [ ] Caracteres espa?oles se ven bien
- [ ] No hay errores en logs de Coolify

---

## ? Configuraci?n Final Probada

### Dockerfile v1.0.3 (FUNCIONANDO)
```dockerfile
FROM node:18-alpine

# Variables UTF-8
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANGUAGE=C.UTF-8

WORKDIR /app
RUN apk add --no-cache caddy
COPY . .

# Caddyfile ultra-simple
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

### HTML con Entidades (FUNCIONANDO)
```html
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>App Base - &ntilde; Espa&ntilde;ol</title>
</head>
<body>
    <h1>App Base - &ntilde; Espa&ntilde;ol</h1>
    <p>Aplicaci&oacute;n base lista para desarrollo</p>
    <p>&iquest;C&oacute;mo est&aacute; usted? &iexcl;Excelente!</p>
</body>
</html>
```

---

## ? Soporte

Si encuentras otros errores:
1. Revisa los logs de Coolify
2. Verifica que el Dockerfile siga el formato exacto de arriba
3. Usa entidades HTML para caracteres especiales
4. Consulta la documentaci?n oficial de Caddy

---

**Documentado por:** xuli70  
**Fecha:** Julio 2025  
**Versi?n:** 1.0.3  
**Estado:** ? Probado en producci?n