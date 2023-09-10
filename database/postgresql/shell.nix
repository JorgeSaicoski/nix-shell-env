{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    postgresql
  ];
  shellHook = ''
    export PGDATA="$PWD/pgdata"
    mkdir -p "$PGDATA"  
    export PGHOST="$PGDATA"
    export PGLOCKFILE="$PGDATA/postmaster.pid"

    if [ ! -f "$PGDATA/postgresql.conf" ]; then
      initdb --locale en_US.UTF-8 -D "$PGDATA"
    fi

    pg_ctl -D "$PGDATA" -l "$PGDATA/logfile" start
    
    systemd-run --user --scope --unit=postgresql -- postgres -D "$PGDATA"

  '';
}