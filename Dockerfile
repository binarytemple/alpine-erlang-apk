FROM alpine as alpine_erlang_builder

MAINTAINER Bryan Hunt <admin@binarytemple.co.uk>

RUN apk update && apk upgrade && apk add --allow-untrusted abuild binutils build-base ccache cmake cmake-doc gcc git snappy-dev

RUN git config --global url."https://github.com/".insteadOf git@github.com: ; git config --global url."https://".insteadOf git://

#install rebar3
#RUN curl https://s3.amazonaws.com/rebar3/rebar3 -o /bin/rebar3 && chmod 755 /bin/rebar3


RUN addgroup builders && adduser builder -D -G abuild -s /bin/bash && echo " builder ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers 

WORKDIR /home/builder

COPY res . 

RUN chown -R builder . 

USER builder

RUN abuild-keygen -an

# in the event of failure we'll want to inspect whatever got built rather than throw it away.
RUN abuild -F -Kkr || exit 0
# abuild -F -Kkr 

