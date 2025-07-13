# App Base

Aplicaci?n base ultra-minimalista para iniciar nuevos proyectos con Coolify.

## ? Caracter?sticas

- ? HTML m?nimo funcional
- ? Dockerfile v1.0.2 probado y funcionando
- ? Configuraci?n ultra-simple de Caddy
- ? Health check incluido
- ? Puerto 8080 configurado
- ? UTF-8 para caracteres espa?oles

## ? Uso

1. **Fork o copia este repositorio**
2. **Modifica `index.html`** con tu contenido
3. **Push a GitHub**
4. **Deploy en Coolify** con Build Pack: Dockerfile

## ? Estructura

```
app-base/
??? index.html      # Tu aplicaci?n aqu?
??? Dockerfile      # Configuraci?n para Coolify
??? README.md       # Este archivo
```

## ? Notas

- Puerto: 8080 (obligatorio para Coolify)
- Server: Caddy
- No necesitas configurar headers de seguridad (Coolify los maneja)

## ?? Para comenzar

Simplemente edita `index.html` y comienza a desarrollar tu aplicaci?n.

---

**Creado por:** xuli70  
**Versi?n:** 1.0.2  
**Base probada:** Julio 2025