# Docker multi-stage build
FROM --platform=${BUILDPLATFORM} golang:1.23.2-alpine AS base

ARG GIT_COMMIT=unspecified
ARG BUILD_IMAGE_ID=unspecified
ARG TARGETPLATFORM
ARG BUILDPLATFORM
ENV GIT_COMMIT=${GIT_COMMIT}
ENV BUILD_IMAGE_ID=${BUILD_IMAGE_ID}

RUN apk add --no-cache curl make
WORKDIR /app

# Fetch dependencies
COPY go.mod go.sum ./
RUN go mod download

RUN echo "I am running on $BUILDPLATFORM, building for $TARGETPLATFORM"

# Now pull in our code
COPY . .
RUN mkdir -p /app/bin \
    && make all

# Final image
FROM scratch AS final
LABEL maintainer="Arulraj V <me@arulraj.net>"
COPY --from=base /app/dist/htpasswd-forward-auth_amd64 /htpasswd-forward-auth
CMD ["/htpasswd-forward-auth"]
