variable "VERSION" {
  default = "dev"
}

variable "GITHUB_REPOSITORY" {
  default = "avjpl/Docker-Bake-Cookbook"
}

variable "DOCKERHUB_USERNAME" {
  default = "avjpl"
}

function "tags" {
  params = [version]
  result = [
    "ghcr.io/${lower(GITHUB_REPOSITORY)}:${version}",
    "ghcr.io/${lower(GITHUB_REPOSITORY)}:latest",
    "${DOCKERHUB_USERNAME}/cookbook-2:${version}",
    "${DOCKERHUB_USERNAME}/cookbook-2:latest"
  ]
}

target "app" {
    dockerfile = "Dockerfile"
    context = "."

  args = {
    VERSION = "${VERSION}"
  }

  tags = tags(VERSION)

  labels = {
    "org.opencontainers.image.source" = "https://github.com/${GITHUB_REPOSITORY}"
    "org.opencontainers.version" = "${VERSION}"
    "org.opencontainers.image.created" = timestamp()
  }
}

group "default" {
  targets = ["app"]
}
