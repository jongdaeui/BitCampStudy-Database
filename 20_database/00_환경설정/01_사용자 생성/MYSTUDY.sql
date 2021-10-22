-- USER SQL
CREATE USER "Mystudy" IDENTIFIED BY "mystudypw"  
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS

-- ROLES
GRANT "CONNECT" TO "Mystudy" ;
GRANT "RESOURCE" TO "Mystudy" ;

-- SYSTEM PRIVILEGES

