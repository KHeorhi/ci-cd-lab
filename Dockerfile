FROM python:3.14-alpine

WORKDIR /app

ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1
ENV UV_PROJECT_ENVIRONMENT=/usr/local

RUN --mount=type=bind,source=pyproject.toml,target=/app/pyproject.toml \
    --mount=type=bind,source=uv.lock,target=/app/uv.lock \
    pip install --no-cache-dir uv &&\
    uv sync --no-dev

COPY main.py ./
COPY src src

CMD uvicorn main:app --port 8000 --reload
