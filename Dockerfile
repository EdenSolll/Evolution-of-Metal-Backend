# Build stage
FROM rust:latest as builder

WORKDIR /app

ARG DATABASE_URL
ENV DATABASE_URL=$DATABASE_URL
ARG DB_PORT
ENV DB_PORT=$DB_PORT
ARG SECURITY_ENABLED
ENV SECURITY_ENABLED=$SECURITY_ENABLED

COPY . .

RUN cargo build --release

# Production stage
FROM archlinux:latest

WORKDIR /usr/local/bin

# Copy the binary to the working directory
COPY --from=builder /app/target/release/backend /usr/local/bin/

# Ensure binary is executable
RUN chmod +x /usr/local/bin/backend

# Set entry point
ENTRYPOINT ["/usr/local/bin/backend"]
