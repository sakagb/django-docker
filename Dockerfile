FROM python:3.10-slim as base

WORKDIR /app
COPY api/poetry.lock /app/poetry.lock
COPY api/pyproject.toml /app/pyproject.toml

# hadolint ignore=DL3013
RUN pip install --no-cache-dir -U poetry pip && \
    python -m venv .venv && \
    poetry install --no-root

FROM python:3.10-slim as build

WORKDIR /app
COPY api/ /app

COPY --from=base /usr/local/lib/python3.10/site-packages/ /usr/local/lib/python3.10/site-packages/
COPY --from=base /usr/local/bin/ /usr/local/bin/
COPY --from=base /app/.venv/ /app/.venv/

FROM build as celery

COPY docker-entrypoint-celery.sh /docker-entrypoint-celery.sh
RUN chmod +x /docker-entrypoint-celery.sh

FROM build as dev

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV DJANGO_SETTINGS_MODULE=config.local

FROM build as production

COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENV DJANGO_SETTINGS_MODULE=config.production

EXPOSE 5000

ENTRYPOINT ["/docker-entrypoint.sh"]
