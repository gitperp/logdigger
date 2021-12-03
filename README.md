
# Log Digger


List errors from IB web log

Print lines from the log only for selected severity level and between given timestamps in the log.

Parameters 
Narrow the search for records between timestamps                                                          
-v after=08:00         Default value 00:00
-v before=12:30:22     Default value 23:59

The times can be of any length. The script compares the timestamps in the file with the length of the provided timestamp.

Severity level to display
-v level=x
where x can be 
ERROR
WARN
INFO
DEBUG
ANY  (all of the above)



Usage:
   Add alias logdigger or logfilter in .bash_aliases
  `alias logdigger='awk -f ~/logdigger.awk'`

   Use without timestamps
>  logdigger 'input web log file'

   Use with both after and before
>  logdigger -v after=08:00 -v before=11:00 /mnt/c/temp/1/w1/web-2021-11-30.txt

Future additions:
- Possibility to set severity level to log (default logging is for ERROR, add e.g. WARN)
- Possibility to not check severity level (if you want to check all levels between two timestamps)
- Add statistics summary in the END section
 

 
