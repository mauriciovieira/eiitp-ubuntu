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
