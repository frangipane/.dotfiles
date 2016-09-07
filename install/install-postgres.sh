## If postgres is already installed, skip installation
which psql &> /dev/null
[ $? -eq 1 ] && conda install --yes postgresql

PGBASE="/usr/local/postgresql"
PGDATA="$PGBASE/data"

if [ ! -d $PGBASE ]; then
    ## create parent directory of data directory, where
    ## postgres keeps databases, i.e. the "database cluster"
    sudo mkdir $PGBASE
    sudo chmod 700 $PGBASE
        
    ## give user permission to write to directory
    sudo chown $USER $PGBASE

    ## initialize the database as user
    ## "superuser" defaults to same name as operating system user
    initdb -D $PGDATA
fi
