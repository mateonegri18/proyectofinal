MAPUNS_api

Despliegue en Docker/Render listo con Python 3.6.8.

Uso local con Docker:

- Construir imagen: `docker build -t proyectofinal-api .`
- Ejecutar: `docker run -p 8000:8000 --env PORT=8000 proyectofinal-api`

Variables de entorno (Render o `docker run -e ...`):

- `SECRET_KEY` (requerida en producción)
- `DATABASE_URL` (PostgreSQL; Render lo inyecta si usas su Postgres)
- `ALLOWED_HOSTS` (opcional, coma-separado; `RENDER_EXTERNAL_HOSTNAME` se agrega automáticamente)
- `DEBUG` (`false` por defecto)

Estructura de ejecución en el contenedor:

- Migra la base: `python api/manage.py migrate --noinput`
- Collectstatic: `python api/manage.py collectstatic --noinput`
- App: `gunicorn api.wsgi:application --bind 0.0.0.0:$PORT`

Para Render:

- Este repo incluye `Dockerfile` y `render.yaml` (servicio web tipo Docker).
- Al crear el servicio, Render detecta el Dockerfile. Configura `SECRET_KEY` y `DATABASE_URL` en Dashboard.
