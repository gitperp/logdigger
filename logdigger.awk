#!/bin/awk
#List errors from IB web log
BEGIN {

#	Get timestamps for after/before. Set default if no value given.
	if (after=="") {
		after="00:00"
	}
	if (before=="") {
		before="23:59"
	}

#	Put valid severity levels in an array.
	allArr["ERROR"] = "ERROR";
	allArr["INFO"] = "INFO";
	allArr["DEBUG"] = "DEBUG";
	allArr["WARN"] = "WARN";

#	Put level to include in output in includeArr. Default is ERROR.
	if (level == "ANY") {
		for (var in allArr) includeArr[var] = "";
		excludeArr["DUMMY"] = "";
	}
	else {
	    
		if (level == "") level = "ERROR"
  		if (level in allArr) 
		    includeArr[level] = level;
		else
		    print "Unknown level ",level;
	}

	for (i in allArr) {
	    if (i in includeArr) {
		;
	    }
	    else {
		excludeArr[i] = "";
    	    }
	}
}
$3 in excludeArr  {inSection=0; next; }
inSection;
($3 in includeArr && substr($2,1,length(after)) >= after && substr($2,1,length(before)) <= before) {print $0; inSection=1; next;} 

