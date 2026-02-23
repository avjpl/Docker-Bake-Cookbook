variable "GITHUB_REPOSITORY" { default = "avjpl/docker-bake-cookbook" }
variable "DOCKERHUB_USERNAME" { default = "avjpl" }
variable "VERSION" {  default = "latest" }
variable "NODE_VERSIONS" { default = ["18", "20", "22"] }

target "app" {
  name = "app-node-${node_version}"

  matrix = {
    node_version = NODE_VERSIONS
  }

  dockerfile = "Dockerfile"
  context = "."

  args = {
    NODE_VERSION = node_version
  }

  tags = [
    "ghcr.io/${lower(GITHUB_REPOSITORY)}:node-${node_version}-${VERSION}",
    "${DOCKERHUB_USERNAME}/cookbook-5:node-${node_version}-${VERSION}",
    node_version == "20" ? "ghcr.io/${lower(GITHUB_REPOSITORY)}:${VERSION}" : "",
    node_version == "20" ? "${DOCKERHUB_USERNAME}/cookbook-5:${VERSION}" : ""
  ]

  labels = {
    "org.opencontainers.image.source" = "https://github.com/${GITHUB_REPOSITORY}"
    "org.opencontainers.created" = timestamp()
    "org.opencontainers.image.version" = VERSION
    "org.opencontainers.image.node_version" = node_version
  }

  cache-from = [
    "type=registry,ref=ghcr.io/${lower(GITHUB_REPOSITORY)}:buildcache-node-${node_version}"
  ]

  cache-to = [
    "type=registry,ref=ghcr.io/${lower(GITHUB_REPOSITORY)}:buildcache-node-${node_version},mode=max"
  ]
}

group "default" {
  targets = ["app"]
}
