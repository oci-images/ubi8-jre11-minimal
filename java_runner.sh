#!/bin/bash
echo "AdoptOpenJDK11 - JRE"
export JRE_OPTION="-XX:+UseParallelOldGC -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=20 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MaxMetaspaceSize=100m -XX:+ExitOnOutOfMemoryError"
if [ ! -z "$JAVA_OPTIONS" ]
then	
	export JRE_OPTION="$JAVA_OPTIONS $JRE_OPTION"
fi	

if [ ! -z "$CLASSPATH" ]
then	
	export JRE_CP="-cp .;$CLASSPATH"
else	
	export JRE_CP="-cp ."
fi	

if [ -z "$JAVA_ARGS" ]
then
	export JRE_ARGS=""		
else
	export JRE_ARGS="$JRE_ARGS $JAVA_ARGS"
fi
	
filesnum=$(ls *.jar | wc -l)
if [ $filesnum = 1 ]; 
then
	jarfile=$(ls *.jar)
	echo "INFO exec java $JRE_OPTION $JRE_CP -jar $jarfile $JRE_ARGS"
	java $JRE_OPTION $JRE_CP -jar $jarfile $JRE_ARGS
else
	if [ -z "$JAR_APP" ]
	then	
		echo "Jar files: ${filesnum}, you must be set JAR_APP"
	else
		echo "INFO exec java $JRE_OPTION $JRE_CP -jar $JAR_APP $JRE_ARGS"
		java $JRE_OPTION $JRE_CP -jar $JAR_APP $JRE_ARGS
	fi	
fi
