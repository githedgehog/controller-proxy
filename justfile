default:
  @just --list

version_dirty := `[ -z "$(git status -s)" ] || echo "-$(date +"%H%M%S")"`
version := `git describe --tags --dirty --always` + version_dirty

tinyproxy_version := "1.11.2"

version:
  @echo "Using version {{version}} with tinyproxy version {{tinyproxy_version}}"

download:
 curl -L --remote-name https://github.com/tinyproxy/tinyproxy/releases/download/{{tinyproxy_version}}/tinyproxy-{{tinyproxy_version}}.tar.xz

uncompress:
  mkdir tinyproxy
  tar --strip-components=1 -C tinyproxy -xaf tinyproxy-{{tinyproxy_version}}.tar.xz

push: && version
  oras push ghcr.io/githedgehog/fabricator/control-proxy:{{version}} tinyproxy


