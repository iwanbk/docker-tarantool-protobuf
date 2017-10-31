FROM vkill/luapbintf

RUN apt update -y
RUN apt install -y sudo vim lsb-release tmux

## install luajit

RUN set -ex \
	&& git clone http://luajit.org/git/luajit-2.0.git \
	&& cd luajit-2.0/ \
	&& git checkout v2.1 \
	&& make && sudo make install \
	&& ln -sf /usr/local/bin/luajit-2.1.0-beta3 /usr/local/bin/luajit

## install tarantool
RUN set -ex \
	&& curl http://download.tarantool.org/tarantool/1.7/gpgkey | sudo apt-key add - \
	&& release=`lsb_release -c -s` \

	# install https download transport for APT
	&& sudo apt-get -y install apt-transport-https \

	# append two lines to a list of source repositories \
	&& sudo rm -f /etc/apt/sources.list.d/*tarantool*.list \
	&& echo  'deb http://download.tarantool.org/tarantool/1.7/debian/ jessie main\n \
	deb-src http://download.tarantool.org/tarantool/1.7/debian/ jessie main\n' \
	>> /etc/apt/sources.list.d/tarantool_1_7.list \
	\
	# install \
	&& sudo apt-get update \
	&& sudo apt-get -y install tarantool