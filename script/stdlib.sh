fail() {
  echo "$@" >&2
  exit 1
}

has() {
  which $1 &>/dev/null
}

install() {
  DEBIAN_FRONTEND=noninteractive apt-get install -qy $@
}
