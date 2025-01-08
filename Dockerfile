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
FROM archlinux:latest

COPY --from=builder /app/target/release/backend .

WORKDIR /usr/local/bin

CMD ["./backend"]
