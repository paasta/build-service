fail() {
  echo "$@" >&2
  exit 1
}

has() {
  which $1 &>/dev/null
}

system_install() {
  DEBIAN_FRONTEND=noninteractive sudo apt-get install -qy $@
}