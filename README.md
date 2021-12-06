
# Log Digger


List filtered entries from IB web log

Print lines from the log only for selected severity level and between given timestamps in the log.

Parameters 
----------
Parameters must be preceded by -v. E.g -v after=10:30

Narrow the search for records between timestamps                                                          
- -v after=08:00         Default value 00:00. Timestamps equal to and greater than 'after'.
- -v before=12:30:22     Default value 24:00. Timestamps less than 'before'.

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

Statistics
----------

At the end a statistics summary is printed.  
The section "Total hits" displays statistics for the entire file.
The section "Selected hits" displays statistics for records that match the selection (level, after, before).

Example output:

> Total hits
> 
> ----------
> 
> Debug:            6
> 
> Info:             0
> 
> Warn:             2
> 
> Error:            2
> 
> 
> Selected hits
> -------------
> Debug:            0
> Info:             0
> Warn:             0
> Error:            2   
> 
