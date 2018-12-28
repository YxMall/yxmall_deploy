#!/bin/sh


JARFILE=yx-platform.jar

echo "stop SpringBoot BAppApiServerApplication"
pid=`ps -ef | grep yx-platform-0.0.1-SNAPSHOT.jar | grep -v grep | awk '{print $2}'`
echo “旧应用进程id：$pid”
if [ -n "$pid" ]
then
kill -9 $pid
fi


BUILD_ID=dontKillMe nohup java -jar $JARFILE --spring.profiles.active=prod  &  > out.log &
if [ $? = 0 ];then
        sleep 30
        tail -n 50 out.log
fi

cd backup/
ls -lt|awk 'NR>5{print $NF}'|xargs rm -rf