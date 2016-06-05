How to make via shell to mysql:
-----

make
sudo rm /usr/local/Cellar/mysql/5.7.11/lib/plugin/libed*.so
sudo cp libed*.so /usr/local/Cellar/mysql/5.7.11/lib/plugin/
mysql -u root
source ./edth.sql 
use moviedb;
select title from movies where edth(title, "zoander", 3); 
