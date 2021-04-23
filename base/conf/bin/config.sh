shopt -s nullglob
function rootCheck() {
    if [ "$(/usr/bin/whoami)" != "root" ]; then
        echo "[ERROR] $* must be run as root"
        exit 1
    fi
}
function createDockerStdoutStderr() {
    if [[ -n "$LOG_STDOUT" ]]; then
        echo "Log stdout redirected to $LOG_STDOUT"
    else
        LOG_STDOUT="/proc/$$/fd/1"
    fi

    if [[ -n "$LOG_STDERR" ]]; then
        echo "Log stderr redirected to $LOG_STDERR"
    else
        LOG_STDERR="/proc/$$/fd/2"
    fi

    ln -f -s "$LOG_STDOUT" /docker.stdout
    ln -f -s "$LOG_STDERR" /docker.stderr
}
function includeScriptDir() {
    if [[ -d "$1" ]]; then
        for FILE in "$1"/*.sh; do
            echo "-> Executing ${FILE}"
            . "$FILE"
        done
    fi
}
function runEntrypoints() {
    ENTRYPOINT_SCRIPT="/opt/docker/bin/entrypoint.d/${TASK}.sh"
    if [ -f "$ENTRYPOINT_SCRIPT" ]; then
        . "$ENTRYPOINT_SCRIPT"
    fi
    if [ -f "/opt/docker/bin/entrypoint.d/default.sh" ]; then
        . /opt/docker/bin/entrypoint.d/default.sh
    fi
    exit 1
}
function runProvisionEntrypoint() {
    includeScriptDir "/opt/docker/provision/entrypoint.d"
    includeScriptDir "/entrypoint.d"
}
function envListVars() {
    if [[ $# -eq 1 ]]; then
        env | grep "^${1}" | cut -d= -f1
    else
        env | cut -d= -f1
    fi
}
function envGetValue() {
    awk "BEGIN {print ENVIRON[\"$1\"]}"
}
