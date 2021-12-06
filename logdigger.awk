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
function addToCounter(severity) {
	switch (severity) {
		case "ERROR": selectedError++;
			break
		case "WARN": selectedWarn++;
			break
		case "DEBUG": selectedDebug++;
			break
		case "INFO": selectedInfo++;
			break
	}
	return;
}

function printSummary(){
	printf("Total hits\n");
	printf("----------\n");
	printf("Debug:   %10s\n", totalDebug);
	printf("Info:    %10s\n", totalInfo);
	printf("Warn:    %10s\n", totalWarn);
	printf("Error:   %10s\n", totalError);

	printf("\n");
	printf("Selected hits\n");
	printf("-------------\n");
	printf("Debug:   %10s\n", selectedDebug);
	printf("Info:    %10s\n", selectedInfo);
	printf("Warn:    %10s\n", selectedWarn);
	printf("Error:   %10s\n", selectedError);
}
BEGIN {

	totalDebug = 0;
	totalInfo = 0;
	totalWarn = 0;
	totalError = 0;
	
	selectedDebug = 0;
	selectedInfo = 0;
	selectedWarn = 0;
	selectedError = 0;


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
($3 == "DEBUG") {totalDebug++1}
($3 == "INFO") {totalInfo++1}
($3 == "WARN") {totalWarn++1}
($3 == "ERROR") {totalError++1}
(isSectionStart($0) && !(doInclude($3, $2, includeArr)))  {printDataLine=0; next; }
(isSectionStart($0) && doInclude($3, $2,includeArr)) {addToCounter($3); printDataLine=1; print getColour($3), $0, "\033[0m"; next;} 
(!(isSectionStart($0)) && printDataLine) { print $0; next; }

END {printSummary()}
