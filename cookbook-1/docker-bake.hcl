# Variables - ALWAYS DEFINE THESE
variable "GITHUB_REPOSITORY" {
  default = "avjpl/docker-bake-cookbook"  # Replace with your GitHub username/repo
}

variable "DOCKERHUB_USERNAME" {
  default = "avjpl"      # Replace with your Docker Hub username
}

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

# Add default group
group "default" {
  targets = ["app"]
}
