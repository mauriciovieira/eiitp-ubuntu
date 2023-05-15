function switch_pg_database() {
  sudo systemctl stop postgresql
  sudo rm /var/lib/postgresql/14/main
  sudo ln -s /var/lib/postgresql/14/main-$1 /var/lib/postgresql/14/main
  sudo systemctl start postgresql
}

function create_pg_database() {
  sudo cp -r /var/lib/postgresql/14/main-$1 /var/lib/postgresql/14/main-$2
}
