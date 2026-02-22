variable "VERSION" {
  default = "latest"
}

variable "GITHUB_REPOSITORY" {
  default = "avjpl/docker-bake-cookbook"
}

variable "DOCKERHUB_USERNAME" {
  default = "avjpl"
}

local {
  repo = lower(GITHUB_REPOSITORY)
}

target "base" {
  labels = {
    "org.opencontainers.image.source" = "https://github.com/${GITHUB_REPOSITORY}"
    "org.opencontainers.created" = timestamp()
    "org.opencontainers.image.version" = VERSION
  }
}

target "frontend" {
  inherits = ["base"]
  dockerfile = "Dockerfile"
  context = "./frontend"

  tags = [
    "ghcr.io/${local.repo}/frontend:${VERSION}",
    "${DOCKERHUB_USERNAME}/cookbook-4-frontend:${VERSION}"
  ]

  cache-from = [
    "type=registry,ref=ghcr.io/${local.repo}/frontend:buildcache"
  ]

  cache-to = [
    "type=registry,ref=ghcr.io/${local.repo}/frontend:buildcache,mode=max"
  ]
}

target "backend" {
  inherits = ["base"]
  dockerfile = "Dockerfile"
  context = "./backend"

  tags = [
    "ghcr.io/${local.repo}/backend:${VERSION}",
    "${DOCKERHUB_USERNAME}/cookbook-4-backend:${VERSION}"
  ]

  cache-from = [
    "type=registry,ref=ghcr.io/${local.repo}/backend:buildcache"
  ]

  cache-to = [
    "type=registry,ref=ghcr.io/${local.repo}/backend:buildcache,mode=max"
  ]
}

target "database" {
  inherits = ["base"]
  dockerfile = "Dockerfile"
  context = "./database"

  tags = [
    "ghcr.io/${local.repo}/database:${VERSION}",
    "${DOCKERHUB_USERNAME}/cookbook-4-database:${VERSION}"
  ]

  cache-from = [
    "type=registry,ref=ghcr.io/${local.repo}/database:buildcache"
  ]

  cache-to = [
    "type=registry,ref=ghcr.io/${local.repo}/database:buildcache,mode=max"
  ]
}

group "default" {
  targets = ["frontend", "backend", "database"]
}

group "app" {
  targets = ["frontend", "backend"]
}
