target "app" {
  dockerfile = "Dockerfile"
  context = "."

  tags = [
    "ghcr.io/${GITHUB_REPOSITORY}:latest",
    "${DOCKERHUB_USERNAME}/cookbook-1:latest"
  ]

  labels = {
    "org.opencontainers.image.source" = "https://github.com/${GITHUB_REPOSITORY}"
    "org.opencontainers.image.created" = timestamp()
  }
}
