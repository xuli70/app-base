# App Base

Aplicaci?n base ultra-minimalista para iniciar nuevos proyectos con Coolify.

## ? Caracter?sticas

- ? HTML m?nimo funcional
- ? Dockerfile v1.0.3 con soporte UTF-8 completo
- ? Configuraci?n ultra-simple de Caddy
- ? Health check incluido
- ? Puerto 8080 configurado
- ? UTF-8 para caracteres espa?oles con entidades HTML
- ? Errores cr?ticos resueltos y documentados

## ? Uso R?pido

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
??? test-spanish.html # Test de caracteres espa?oles
??? TROUBLESHOOTING.md # Errores cr?ticos y soluciones
```

## ?? ERRORES CR?TICOS RESUELTOS (Julio 2025)

### ? ERROR 1: Headers duplicados en Caddyfile
**S?ntomas:** `Error: cannot specify headers in both arguments and block, at /app/Caddyfile`

**? NO HACER:**
```dockerfile
# INCORRECTO - Causa error
header / {
    Content-Type "text/html; charset=utf-8"
}
```

**? SOLUCI?N:**
```dockerfile
# CORRECTO - Header directo sin bloques
header Content-Type text/html; charset=utf-8
```

### ? ERROR 2: Caracteres espa?oles corruptos (?, tildes)
**S?ntomas:** Caracteres como `?` en lugar de ?, ?, ?, ?, ?, ?

**? NO FUNCIONA:**
- Confiar solo en meta charset="UTF-8"
- Variables de entorno LANG ?nicamente
- Headers Content-Type en Caddyfile

**? SOLUCI?N DEFINITIVA:**
```html
<!-- Usar entidades HTML para caracteres espa?oles -->
&ntilde; &aacute; &eacute; &iacute; &oacute; &uacute;
&iquest; &iexcl; &Ntilde; &Aacute; &Eacute; etc.
```

## ? Notas Importantes

- **Puerto:** 8080 (obligatorio para Coolify)
- **Server:** Caddy (mejor compatibilidad que nginx)
- **Headers:** Coolify maneja autom?ticamente headers de seguridad
- **UTF-8:** Usar entidades HTML para m?xima compatibilidad

## ?? Para Comenzar

Simplemente edita `index.html` y comienza a desarrollar tu aplicaci?n.

**Para caracteres espa?oles:** Usa entidades HTML o consulta `test-spanish.html` como referencia.

## ? Documentaci?n Adicional

- `TROUBLESHOOTING.md` - Gu?a completa de errores y soluciones
- `test-spanish.html` - Test completo de caracteres espa?oles

---

**Creado por:** xuli70  
**Versi?n:** 1.0.3  
**Base probada:** Julio 2025  
**Estado:** ? Funcionando en producci?n con Coolify