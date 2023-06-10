[ -d db ] || mkdir -p ~/db/
docker exec my-database /usr/bin/mysqldump -u root --password=1234 students > ~/db/"$(date +%d_%b_%Y_%H%M).gz"