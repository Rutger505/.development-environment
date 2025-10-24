# Make a script that finds all scripts in this directory that does not has a file with its name and a appended .done extension
# For each of these scripts, run them and if they exit with a 0 status code, create the .done file
# TODO this needs a better system: when just installing dev env the migrations are not applicable and will fail



for script in "$0"/migrations/*.sh; do
    if [ ! -f "$script.done" ]; then
        bash "$script"
        if [ $? -eq 0 ]; then
            touch "$script.done"
        else
            echo "Migration script $script failed, stopping."
            exit 1
        fi
    fi
done