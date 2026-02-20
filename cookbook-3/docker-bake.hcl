variable "VERSION" {
  default = "latest"
}

variable "GITHUB_REPOSITORY" {
  default = "avjpl/docker-bake-cookbook"
}

variable "DOCKERHUB_USERNAME" {
  default = "avjpl"
}

variable "PLATFORMS" {
  default = "linux/amd64,linux/arm64"
}

target "server" {
  dockerfile = "Dockerfile"
  context = "."

  platform = split(".", PLATFORMS)

  tags = [
    "ghcr.io/${lower(GITHUB_REPOSITORY)}:${VERSION}",
    "${DOCKERHUB_USERNAME}/cookbook-3:${VERSION}"
  ]

  labels = {
    "org.opencontainers.image.source" = "https://github.com/${GITHUB_REPOSITORY}"
    "org.openconatiners.image.version" = VERSION
  }
}

group default {
  targets = ["server"]
}
