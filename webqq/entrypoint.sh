#!/bin/bash

perl -MMojo::Webqq -e 'Mojo::Webqq->new(log_encoding=>"utf8")->load(["ShowMsg","UploadQRcode"])->load("Openqq",data=>{listen=>[{port=>$ENV{MOJO_WEBQQ_PLUGIN_OPENQQ_PORT}//5000}],post_api=>$ENV{MOJO_WEBQQ_PLUGIN_OPENQQ_POST_API}})->run'
