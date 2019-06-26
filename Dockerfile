FROM centos:7

LABEL maintainer="Kong Core Team <team-core@konghq.com>"
LABEL description="Centos 7 + Kong 1.0.0 + kong-oidc-oauth plugin"

ARG SU_EXEC_VERSION=0.2
ARG SU_EXEC_URL="https://github.com/ncopa/su-exec/archive/v${SU_EXEC_VERSION}.tar.gz"

RUN yum install -y -q gcc make \
    && curl -sL "${SU_EXEC_URL}" | tar -C /tmp -zxf - \ 
    && make -C "/tmp/su-exec-${SU_EXEC_VERSION}" \
    && cp "/tmp/su-exec-${SU_EXEC_VERSION}/su-exec" /usr/bin \
    && rm -fr "/tmp/su-exec-${SU_EXEC_VERSION}" \
    && yum autoremove -y -q gcc make \
    && yum clean all -q \
    && rm -fr /var/cache/yum/* /tmp/yum_save*.yumtx /root/.pki

ARG KONG_VERSION=1.0.0
ADD kong-community-edition-$KONG_VERSION.el7.noarch.rpm .
RUN useradd --uid 1337 kong \
    && yum install -y kong-community-edition-$KONG_VERSION.el7.noarch.rpm 

COPY kong-oidc-auth kong-oidc-auth
RUN cd kong-oidc-auth \
    && luarocks make *.rockspec

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 8000 8443 8001 8444

STOPSIGNAL SIGTERM

CMD ["kong", "docker-start"]
