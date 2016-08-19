#!/bin/bash

SENTRY_VERSION="8.7.0"
SENTRY_REDIS_VERSION="3.2.3"
SENTRY_POSTGRES_VERSION="9.5.3"
SENTRY_PORT="8090"
POSTGRES_PASSWORD="secret"
POSTGRES_USER="sentry"
SENTRY_SECRET_KEY=''
SENTRY_SERVER_EMAIL=''
SENTRY_EMAIL_HOST='' 
SENTRY_EMAIL_USER=''
SENTRY_EMAIL_PASSWORD=''
REDIS_ADDRESS=''
REDIS_PORT_6379_TCP_ADDR=""
GITHOST=""
CONFIGDIR="`pwd`/config"

# don't modify
EXEC_CMD="$1"
GITHOST_CMD=""
USE_CONFIG_CMD=""
REDIS_LINK_CMD=""
REDIS_SETENV_CMD=""
REDIS_ADDHOST_CMD=""



if [ "$EXEC_CMD" == 'init' ];then

  echo "init sentry..."

  if [ -d $CONFIGDIR ];then
    USE_CONFIG_CMD="-v $CONFIGDIR:/etc/sentry"
    echo -e "\033[33mStarting Sentry with config!\033[0m"
  else
    echo -e "\033[33mStartting Sentry no config!\033[0m"
  fi

  if [ -n "$GITHOST" ];then
    GITHOST_CMD="--add-host $GITHOST"
    echo -e "\033[33mSetting Git Host!\033[0m"
  fi

  if [ -z "$REDIS_PORT_6379_TCP_ADDR" ] || [ -z "$REDIS_ADDRESS" ];then
   
    sudo docker run -d --name sentry-redis redis:$SENTRY_REDIS_VERSION 1>/dev/null
    
    REDIS_LINK_CMD="--link sentry-redis:redis "

    if [ "$?" == "0" ];then
      echo -e "\033[32msentry-redis boot success...\033[0m"
    else
      echo -e "\033[31msentry-redis boot failed...\033[0m"
      echo "The Program will be exit!"
      exit 1
    fi
  
  else
    echo -e "\033[33mSetting Redis Address!\033[0m"
    REDIS_SETENV_CMD="-e REDIS_PORT_6379_TCP_ADDR=$REDIS_PORT_6379_TCP_ADDR"
    REDIS_ADDHOST_CMD="--add-host redis:$REDIS_ADDRESS"
  fi
  

  if [ -z "$SENTRY_SECRET_KEY" ];then
    
    echo -e "\033[33mThe secret key is not found,will be create!\033[0m"
    
    SENTRY_SECRET_KEY=`sudo docker run --rm sentry:$SENTRY_VERSION config generate-secret-key`
  
  else
    echo -e "\033[33mSetting secret key!\033[0m"
  fi

  sudo docker run -d --name sentry-postgres \
                  -e POSTGRES_PASSWORD=$POSTGRES_PASSWORD \
                  -e POSTGRES_USER=$POSTGRES_USER postgres:$SENTRY_POSTGRES_VERSION \
                  1>/dev/null

  if [ "$?" == "0" ];then
    echo -e "\033[32msentry-postgres boot success...\033[0m"
  else
    echo -e "\033[31msentry-postgres boot failed...\033[0m"
    echo "The Program will be exit!"
    exit 1
  fi


  echo "sleep 10s waiting postgres started..."
 
  sleep 10
  
  echo -e "\033[33mStarting init database!\033[0m"

  sudo docker run -it --rm -e SENTRY_SECRET_KEY="$SENTRY_SECRET_KEY" \
                           $REDIS_SETENV_CMD \
                           --link sentry-postgres:postgres \
                           $REDIS_LINK_CMD \
                           $REDIS_ADDHOST_CMD \
                           sentry:$SENTRY_VERSION upgrade


  if [ "$?" == "0" ];then
    echo ""
    echo -e "\033[32msentry database init success...\033[0m"
  else
    echo -e "\033[31msentry database init failed...\033[0m"
    echo "The Program will be exit!"
    exit 1
  fi


  sudo docker run -d --name sentry \
                  -e SENTRY_SECRET_KEY="$SENTRY_SECRET_KEY" \
                  -e SENTRY_SERVER_EMAIL="$SENTRY_SERVER_EMAIL" \
                  -e SENTRY_EMAIL_HOST="$SENTRY_EMAIL_HOST" \
                  -e SENTRY_EMAIL_USER="$SENTRY_EMAIL_USER" \
                  -e SENTRY_EMAIL_PASSWORD="$SENTRY_EMAIL_PASSWORD" \
                  $REDIS_SETENV_CMD \
                  $REDIS_LINK_CMD \
                  --link sentry-postgres:postgres \
                  $REDIS_ADDHOST_CMD \
                  -p $SENTRY_PORT:9000 \
                  $GITHOST_CMD \
                  $USE_CONFIG_CMD  sentry:$SENTRY_VERSION 1>/dev/null

  if [ "$?" == "0" ];then
    echo -e "\033[32msentry boot success...\033[0m"
  else
    echo -e "\033[31msentry boot failed...\033[0m"
    echo "The Program will be exit!"
    exit 1
  fi


  sudo docker run -d --name sentry-cron \
                  -e SENTRY_SECRET_KEY="$SENTRY_SECRET_KEY" \
                  -e SENTRY_SERVER_EMAIL="$SENTRY_SERVER_EMAIL" \
                  -e SENTRY_EMAIL_HOST="$SENTRY_EMAIL_HOST" \
                  -e SENTRY_EMAIL_USER="$SENTRY_EMAIL_USER" \
                  -e SENTRY_EMAIL_PASSWORD="$SENTRY_EMAIL_PASSWORD" \
                  $REDIS_SETENV_CMD \
                  $REDIS_LINK_CMD \
                  --link sentry-postgres:postgres \
                  $REDIS_ADDHOST_CMD \
                  sentry:$SENTRY_VERSION run cron 1>/dev/null

  if [ "$?" == "0" ];then
    echo -e "\033[32msentry-cron boot success...\033[0m"
  else
    echo -e "\033[31msentry-cron boot failed...\033[0m"
    echo "The Program will be exit!"
    exit 1
  fi


  sudo docker run -d --name sentry-worker \
                  -e SENTRY_SECRET_KEY="$SENTRY_SECRET_KEY" \
                  -e SENTRY_SERVER_EMAIL="$SENTRY_SERVER_EMAIL" \
                  -e SENTRY_EMAIL_HOST="$SENTRY_EMAIL_HOST" \
                  -e SENTRY_EMAIL_USER="$SENTRY_EMAIL_USER" \
                  -e SENTRY_EMAIL_PASSWORD="$SENTRY_EMAIL_PASSWORD" \
                  $REDIS_SETENV_CMD \
                  $REDIS_LINK_CMD \
                  --link sentry-postgres:postgres \
                  $REDIS_ADDHOST_CMD \
                  sentry:$SENTRY_VERSION run worker 1>/dev/null

  if [ "$?" == "0" ];then
    echo -e "\033[32msentry-worker boot success...\033[0m"
  else
    echo -e "\033[31msentry-worker boot failed...\033[0m"
    echo "The Program will be exit!"
    exit 1
  fi

  echo ""
  echo ""
  echo -e "\033[32m######################################################\033[0m"
  echo -e "\033[32m#\033[0m"
  echo -e "\033[32m#  Sentry Started Success!\033[0m"
  echo -e "\033[32m#\033[0m"
  echo -e "\033[32m#  The Secret Key is:\033[0m"
  echo -e "\033[32m#\033[0m"
  echo -e "\033[32m#  $SENTRY_SECRET_KEY\033[0m"
  echo -e "\033[32m#\033[0m"
  echo -e "\033[32m#######################################################\033[0m"
  echo ""
  echo ""

  sudo docker ps

elif [ "$EXEC_CMD" == 'start' ];then
  echo "start sentry..."

  for contianer in sentry-redis sentry-postgres sentry sentry-cron sentry-worker;do
    
    if [ -n "$REDIS_PORT_6379_TCP_ADDR" ] && [ -n "$REDIS_ADDRESS" ] && [ "$contianer" == "sentry-redis" ];then
      continue
    fi
    
    echo -e "\033[33mstart contianer $contianer\033[0m"
    sudo docker start "$contianer" 1>/dev/null
    if [ "$?" == "0" ];then
      echo -e "\033[32m$contianer start success...\033[0m"
    else 
      echo -e "\033[31m$contianer start failed...\033[0m"
    fi

  done

elif [ "$EXEC_CMD" == 'stop' ];then
  echo "stop sentry..."
  for contianer in sentry-cron sentry-worker sentry sentry-redis sentry-postgres;do
  
    if [ -n "$REDIS_PORT_6379_TCP_ADDR" ] && [ -n "$REDIS_ADDRESS" ] && [ "$contianer" == "sentry-redis" ];then
      continue
    fi
  
    echo -e "\033[33mstop contianer $contianer\033[0m"
    sudo docker stop "$contianer" 1>/dev/null
    if [ "$?" == "0" ];then
      echo -e "\033[32m$contianer stop success...\033[0m"
    else
      echo -e "\033[31m$contianer stop failed...\033[0m"
    fi

  done
elif [ "$EXEC_CMD" == 'delete' ];then
  echo "delete sentry..."
  for contianer in sentry-redis sentry-postgres sentry sentry-cron sentry-worker;do
  
    if [ -n "$REDIS_PORT_6379_TCP_ADDR" ] && [ -n "$REDIS_ADDRESS" ] && [ "$contianer" == "sentry-redis" ];then
      continue
    fi

    echo -e "\033[33mdelete contianer $contianer\033[0m"
    sudo docker rm -f "$contianer" 1>/dev/null
    if [ "$?" == "0" ];then
      echo -e "\033[32m$contianer delete success...\033[0m"
    else
      echo -e "\033[31m$contianer delete failed...\033[0m"
    fi

  done

else
  echo ""
  echo -e "\033[32mPlease input {init|start|stop|delete} to operate sentry! \033[0m"
  echo ""
fi
