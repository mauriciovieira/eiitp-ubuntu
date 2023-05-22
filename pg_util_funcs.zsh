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

function remove_pg_database() {
  sudo rm -rf /var/lib/postgresql/14/main-$1
}

function current_pg_database() {
  basename $(readlink -f /var/lib/postgresql/14/main)
}

function list_pg_databases() {
  for dir in /var/lib/postgresql/14/main-*; do
    echo "$(basename $dir) - $(stat -c %y $dir)"
  done
}

function reset_pg_database() {
  echo "> Current pg database"
  current_pg_database
  echo "> Switching to master"
  switch_pg_database master
  echo "> Removing $1"
  remove_pg_database $1
  echo "> Creating database $1"
  create_pg_database master $1
  echo "> Switching to $1"
  switch_pg_database $1
}
