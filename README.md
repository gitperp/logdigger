
* Log Digger

List errors from IB web log
Print lines where field 3 is ERROR, and the following lines until field 3 is DEBUG, WARN or INFO
Two parameters can be used to narrow the search for records between timestamps                                                           
after=08:00         Default value 00:00
before=12:30:22     Default value 23:59
The times can be of any length. The script compares the timestamps in the file with the length of the provided timestamp. 

Usage:
   Add alias logdigger or logfilter in .bash_aliases
   alias logdigger='awk -f ~/logdigger.awk'
   Use without timestamps
   logdigger 'input web log file'
   
   Use with both after and before
   logdigger -v after=08:00 -v before=11:00 /mnt/c/temp/1/w1/web-2021-11-30.txt
   

Future additions:
- Possibility to set severity level to log (default logging is for ERROR, add e.g. WARN)
- Colour date+time to easily spot new error sections
- Add summary in END section (number of errors)

