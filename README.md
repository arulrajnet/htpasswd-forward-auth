Htpasswd Forward Auth
======================

A forward authentication service based on the `.htpasswd` file for reverse proxies such as nginx, traefik, apisix and etc., This creates cookie session on login and verifies it on each request.



## Development

### Setup Dev environment



### Docker Build

```bash
docker compose build
```

This will create a multi-platform image. To enable multiple platforms, you have to create builder with `docker-container` driver

```bash
docker buildx create --name multiarch --driver docker-container --use
docker builder ls
```

To switch back to normal builder

```bash
docker buildx use default
```

### Docker Push

```bash
docker compose build --push
```
