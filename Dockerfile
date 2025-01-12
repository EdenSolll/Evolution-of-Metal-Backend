# Build stage
FROM rust:latest as builder

WORKDIR /app

ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL
ARG DB_PORT
ENV DB_PORT=$DB_PORT
ARG SECURITY_ENABLED
ENV SECURITY_ENABLED=$SECURITY_ENABLED
ARG DOMAIN
ENV DOMAIN=$DOMAIN

COPY . .

RUN cargo build --release

# Production stage
FROM docker.io/debian:bookworm

WORKDIR /usr/local/bin

COPY --from=builder /app/target/release/backend .

CMD ["./backend"]
