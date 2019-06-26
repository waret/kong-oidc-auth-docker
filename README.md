# curl -s -X POST http://localhost:8001/plugins \
    --data "name=kong-oidc-auth" \
    --data "config.authorize_url=http://keycloak.10.20.1.72.nip.io/auth/realms/jhipster/protocol/openid-connect/auth" \
    --data "config.scope=openid+profile+email" \
    --data "config.token_url=http://keycloak.10.20.1.72.nip.io/auth/realms/jhipster/protocol/openid-connect/token" \
    --data "config.client_id=web_app" \
    --data "config.client_secret=web_app" \
    --data "config.user_url=http://keycloak.10.20.1.72.nip.io/auth/realms/jhipster/protocol/openid-connect/userinfo" \
    --data "config.user_keys=email,name,sub" \
    --data "config.salt=b3253141ce67204b" \
