-- sqlplus / as sysdba

archive log list
shutdown
    immediate startup mount
ALTER DATABASE ARCHIVELOG;

ALTER DATABASE OPEN;

-- rman TARGET /

BACKUP DATABASE;

CONFIGURE RETENTION POLICY TO REDUNDANCY 2;

DELETE OBSOLETE;

RESTORE DATABASE;

show parameter pga SELECT name, value FROM V$DIAG_INFO;

SELECT name, total_mb, free_mb FROM V$ASM_DISKGROUP;