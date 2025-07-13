# =================================
# DOCKERFILE APP BASE v1.0.3
# Aplicaci?n base ultra-simple para Coolify
# SOPORTE COMPLETO UTF-8 PARA ESPA?OL
# =================================

FROM node:18-alpine

LABEL maintainer="xuli70"
LABEL description="Aplicaci?n base para nuevos proyectos con soporte espa?ol"
LABEL version="1.0.3"

# Configurar localizaci?n y UTF-8 para caracteres espa?oles
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV LANGUAGE=C.UTF-8

WORKDIR /app

# Instalar Caddy
RUN apk add --no-cache caddy

# Copiar archivos
COPY . .

# Crear Caddyfile ultra-simple (SIN HEADERS COMPLEJOS) con UTF-8
RUN echo -e ":${PORT:-8080} {\n\
    root * /app\n\
    file_server\n\
    try_files {path} /index.html\n\
    encode gzip\n\
    \n\
    # Configuraci?n para caracteres espa?oles\n\
    header / {\n\
        Content-Type \"text/html; charset=utf-8\"\n\
    }\n\
    \n\
    header *.html {\n\
        Content-Type \"text/html; charset=utf-8\"\n\
    }\n\
    \n\
    header *.css {\n\
        Content-Type \"text/css; charset=utf-8\"\n\
    }\n\
    \n\
    header *.js {\n\
        Content-Type \"application/javascript; charset=utf-8\"\n\
    }\n\
    \n\
    log {\n\
        output stdout\n\
        format console\n\
    }\n\
}" > /app/Caddyfile

# Puerto 8080 (REQUERIDO por Coolify)
EXPOSE 8080

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://localhost:8080/ || exit 1

# Comando de inicio con soporte UTF-8
CMD ["caddy", "run", "--config", "/app/Caddyfile", "--adapter", "caddyfile"]

# =================================
# CHANGELOG:
# v1.0.3 - UTF-8 COMPLETO para caracteres espa?oles
# - Variables de entorno LANG, LC_ALL configuradas
# - Content-Type charset=utf-8 en headers HTTP
# - Soporte para ?, tildes, di?resis, etc.
# - Configuraci?n espec?fica para archivos HTML, CSS, JS
# =================================