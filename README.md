
# Log Digger


List errors from IB web log

Print lines from the log only for selected severity level and between given timestamps in the log.

Parameters 
Narrow the search for records between timestamps                                                          
- after=08:00         Default value 00:00
- before=12:30:22     Default value 23:59

The times can be of any length. The script compares the timestamps in the file with the length of the provided timestamp.

Severity level to display
-v level=x
where x can be 
- ERROR
- WARN
- INFO
- DEBUG
- ANY  (all of the above)



Usage:
   Add alias logdigger or logfilter in .bash_aliases
  `alias logdigger='awk -f ~/logdigger.awk'`

   Use without parameters. Default is ERROR records for all timestamps.
>  logdigger 'input web log file'

   Select with after and before from the log file /mnt/c/temp/web.txt
>  logdigger after=08:00 before=11:00 /mnt/c/temp/web.txt
   
   Select WARN records before 10:30
>  logdigger level=WARN  before=11:00 /mnt/c/temp/web.txt


Future additions:
- Possibility to not check severity level (if you want to check all levels between two timestamps)
- Add statistics summary in the END section
 

 
