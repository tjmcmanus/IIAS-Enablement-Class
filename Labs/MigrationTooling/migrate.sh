#!/bin/bash

# Make appropriate changes to the following variables.  NOTE: given the size of this class only use 1 thread
threads="1"
loader="extTab"
cksum=yes
tout=1800
sdb=bdi      # change XX to your assigned team number
tdb=BLUDB
shost=localhost
suser="admin" # change XX to your assigned team number
tuser="bluadmin"   # change XX to your assigned team number
spw="password"
tpw="bluadmin"
tschema="bdi"  # change XX to your assigned team number
schema="admin"

echo "------------------------------------------------------------------"
echo "db_migration started @ `date`"
echo "------------------------------------------------------------------"

#for host in node0101 node0102 node0103 node0104 node0105 node0106 node0107
#do
#   ssh ${host} nmon -fT -s 5 -c 720 -m /scratch/migrate/
#done

start=`date '+%s'`

dbmig="db_migrate -cksum ${cksum} -loader ${loader} -threads ${threads} -timeout ${tout} -sDB ${sdb} -tDB ${tdb} -sHost ${shost} -sUser ${suser} -tUser ${tuser} -sPassword ${spw} -tPassword ${tpw}  -schema ${schema} -tschema ${tschema} -CreateTargetTable yes -TruncateTargetTable yes"
echo "Executing the following command:"
echo "  ${dbmig}"
${dbmig}

end=`date '+%s'`
elapsed=`expr $end - $start`
echo "------------------------------------------------------------------"
echo "db_migration started @ `date`"  Total elapsed time: ${elapsed} seconds.
echo "------------------------------------------------------------------"
