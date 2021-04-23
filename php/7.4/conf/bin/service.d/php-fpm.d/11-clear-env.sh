VARIABLE_LIST="; Workaround for missing clear_env feature in PHP-FPM"
for envVariable in $(printenv | cut -f1 -d=); do
    case "$envVariable" in
    "_" | "PATH" | "PWD") ;;

    \
        *)
        envVariableContent="${!envVariable}"
        if [[ -n "$envVariableContent" ]]; then
            envVariableContent=${envVariableContent//\"/\\\"}
            VARIABLE_LIST="${VARIABLE_LIST}"$'\n'"env[${envVariable}] = \"${envVariableContent}\""
        fi
        ;;
    esac

done
sed -i "s/;#CLEAR_ENV_WORKAROUND#.*/$VARIABLE_LIST/g" /opt/docker/etc/php/fpm/pool.d/*.conf
