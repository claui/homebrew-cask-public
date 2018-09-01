#!/bin/bash
set -eu

PKGNAME='famitracker'
APPNAME_UPSTREAM='FamiTracker'
EXE="C:/Program Files/${APPNAME_UPSTREAM}/FamiTracker.exe"

echo >&2 "Initializing"

RESOURCES_DIR="$(
  cd "$(dirname "${BASH_SOURCE[0]}")/../Resources"
  pwd
)"

WORKDIR="$(
  osascript -e "POSIX path of (path to application support folder`
    ` from user domain)"
)${APPNAME_UPSTREAM}"

export WINEARCH='win32'
export WINEPREFIX="${WORKDIR}/wine"

APPDIR_PARENT="${WINEPREFIX}/drive_c/Program Files"

USER_FAVORITEDIR_TARGET="${WINEPREFIX}/drive_c/users/$(whoami)`
  `/Favorites"
USER_LOGDIR="${WORKDIR}/log"
USER_LOGFILE_STDOUT="${USER_LOGDIR}/${PKGNAME}_out.log"
USER_LOGFILE_STDERR="${USER_LOGDIR}/${PKGNAME}_err.log"

mkdir -p "${USER_LOGDIR}"
: > "${USER_LOGFILE_STDOUT}"
: > "${USER_LOGFILE_STDERR}"

echo >&2 "Logging stdout to: ${USER_LOGFILE_STDOUT}"
echo >&2 "Logging stderr to: ${USER_LOGFILE_STDERR}"

echo >&2 "Checking for Homebrew prefix"

{
  printf 'Original PATH: %s\n' "${PATH}"
  export PATH="/usr/local/bin:/usr/local/sbin:${PATH}"
  printf 'Modified PATH: %s\n' "${PATH}"
  printf 'Homebrew prefix: %s\n' "$(brew --prefix)"
} \
  >> "${USER_LOGFILE_STDOUT}" 2>> "${USER_LOGFILE_STDERR}"

echo >&2 "Checking for Wine prefix"

if ! [ -d "${WINEPREFIX}" ]; then
  FIRST_RUN=1
fi

if [[ "${FIRST_RUN:-0}" -ne '0' ]]; then
  echo >&2 "==> Bootstrapping Wine prefix"
  (
    mkdir -pv "${WINEPREFIX}"
    wineboot -i
    rm -fv "${WINEPREFIX}/dosdevices/z:"
  ) >> "${USER_LOGFILE_STDOUT}" 2>> "${USER_LOGFILE_STDERR}"
  echo >&2 "==> Done"
fi

echo >&2 "==> Creating symlink to app directory"
(
  mkdir -pv "${APPDIR_PARENT}"
  ln -fnsv "${RESOURCES_DIR}" \
    "${APPDIR_PARENT}/${APPNAME_UPSTREAM}"
) >> "${USER_LOGFILE_STDOUT}" 2>> "${USER_LOGFILE_STDERR}"

if [[ "${FIRST_RUN:-0}" -ne '0' ]]; then
  echo >&2 "==> Configuring ${APPNAME_UPSTREAM}"
  (
    regedit \
      "C:/Program Files/${APPNAME_UPSTREAM}`
        `/patch_buffer_length.reg"
    ln -fnsv "${RESOURCES_DIR}/Demo songs" \
      "${USER_FAVORITEDIR_TARGET}/"
  ) >> "${USER_LOGFILE_STDOUT}" 2>> "${USER_LOGFILE_STDERR}"
fi

if [[ "${HOMEBREW_WINE_DRY_RUN:-0}" -ne '0' ]]; then
  echo >&2 'Not launching because HOMEBREW_WINE_DRY_RUN is set.'
  exit 0
fi

echo >&2 "Launching ${APPNAME_UPSTREAM} via Wine"

exec wine "${EXE}" \
  >> "${USER_LOGFILE_STDOUT}" 2>> "${USER_LOGFILE_STDERR}"
