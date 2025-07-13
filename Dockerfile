# =================================
# DOCKERFILE APP BASE v1.0.2
# Aplicaci?n base ultra-simple para Coolify
# =================================

FROM node:18-alpine

LABEL maintainer="xuli70"
LABEL description="Aplicaci?n base para nuevos proyectos"
LABEL version="1.0.2"

WORKDIR /app

# Instalar Caddy
RUN apk add --no-cache caddy

# Copiar archivos
COPY . .

# Crear Caddyfile ultra-simple (SIN HEADERS COMPLEJOS)
RUN echo -e ":${PORT:-8080} {\n\
    root * /app\n\
    file_server\n\
    try_files {path} /index.html\n\
    encode gzip\n\
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

# Comando de inicio
CMD ["caddy", "run", "--config", "/app/Caddyfile", "--adapter", "caddyfile"]