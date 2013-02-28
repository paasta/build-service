fail() {
  echo "$@" >&2
  exit 1
}

has() {
  which $1 &>/dev/null
}

system_install() {
  if [ -z "$system_updated" ]; then
    sudo apt-get update -qy
    system_updated=1
  fi
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -qy $@
}