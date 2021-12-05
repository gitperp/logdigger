#!/bin/awk
#List errors from IB web log
function getColour(severity) {
#  30 - black   34 - blue          
#  31 - red     35 - magenta       
#  32 - green   36 - cyan          
#  33 - yellow  37 - white        
	switch (severity) {
		case "ERROR": return "\033[31m";	# Red
		case "WARN": return "\033[33m";		# Yellow
		case "DEBUG": return "\033[32m";	# Green
		case "INFO": return "\033[36m";		# Cyan
		default: return "";
	}
}
function doInclude(severity, timestamp, includeArr) {
	return severity in includeArr && substr(timestamp,1,length(after)) >= after && substr(timestamp,1,length(before)) <= before
	}
function isSectionStart (str) {
	return str ~ "^[0-9]{1,4}-[0-1][0-2]-[0-3][0-9] [0-9]{2}:[0-9]{2}"  
}
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

#	Level=ANY, put all levels in includeArr
	if (level == "ANY") {
		for (var in allArr) includeArr[var] = var;
	}
	else {
#		    
		if (level == "") level = "ERROR"
  		if (level in allArr) 
		    includeArr[level] = level;
		else
		    print "Unknown level ",level;
	}
}
#{print isSectionStart($0), doInclude($3, $2, includeArr), $0}
(isSectionStart($0) && !(doInclude($3, $2, includeArr)))  {printDataLine=0; next; }
(isSectionStart($0) && doInclude($3, $2,includeArr)) {printDataLine=1; print getColour($3), $0, "\033[0m"; next;} 
(!(isSectionStart($0)) && printDataLine) { print $0; next; }

