function switch_pg_database() {
  sudo systemctl stop postgresql@14-main
  sudo rm /var/lib/postgresql/14/main
  sudo ln -s /var/lib/postgresql/14/main-$1 /var/lib/postgresql/14/main
  sudo chown -h postgres:postgres /var/lib/postgresql/14/main
  sudo systemctl start postgresql@14-main
}

function create_pg_database() {
  sudo cp -r /var/lib/postgresql/14/main-$1 /var/lib/postgresql/14/main-$2
  sudo chown -R postgres:postgres /var/lib/postgresql/14/main-$2
}

function current_pg_database() {
  basename $(readlink -f /var/lib/postgresql/14/main)
}

function list_pg_databases() {
  for dir in /var/lib/postgresql/14/main-*; do
    echo "$(basename $dir) - $(stat -c %y $dir)"
  done
}
