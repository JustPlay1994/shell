#!/bin/sh
#chkconfig: 2345 80 05
#description: es

export JAVA_HOME=/usr/local/java/jdk8/jdk1.8.0_171
export JAVA_BIN=/usr/local/java/jdk8/jdk1.8.0_171/bin
export PATH=$PATH:$JAVA_HOME/bin
export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH

case $1 in
start)
#下面的“<<!”是切换用户后，待执行的命令，执行完后使用“!”来进行结束
    su yanfazu<<!
    cd /data/app/elasticsearch6.2.3ft/elasticsearch-6.2.3
    ./bin/elasticsearch -d
exit
!
#上面的“!”是以上面的对应起来，并且顶格放置，这是语法
    echo "es startup" #将该行替换成你自己的服务启动命令
    ;;
stop)
    es_pid=`ps aux|grep elasticsearch | grep -v 'grep elasticsearch' | awk '{print $2}'` #注意这个号"`"
    kill -9 $es_pid
    echo "es stop" #将该行替换成你自己的服务启动命令
    ;;
restart)
    es_pid=`ps aux|grep elasticsearch | grep -v 'grep elasticsearch' | awk '{print $2}'` #“grep -v”过滤掉本身的执行命令，获取准确>的pid
    kill -9 $es_pid
    echo "es stopup" #将该行替换成你自己的服务启动命令
    su yanfazu<<!
    /data/app/elasticsearch6.2.3ft/elasticsearch-6.2.3
    ./bin/elasticsearch -d
!
    echo "es startup" #将该行替换成你自己的服务启动命令
    ;;
status)
    echo `ps aux|grep elasticsearch | grep -v 'grep elasticsearch'`
    ;;
*)
    echo "start|stop|restart" #将该行替换成你自己的服务启动命令
    ;;
esac