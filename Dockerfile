FROM docker.io/almalinux/9-init:9.1-20221201

RUN dnf -qy upgrade \
 && dnf -qy install \
       composer-cli \
       jq \
       lorax-templates-almalinux \
       osbuild-composer \
 && dnf clean all \
 && systemctl enable osbuild-composer.socket \
 && mkdir -p /etc/osbuild-composer/repositories \
 && jq 'del(.[][].gpgkey) | .[][].check_gpg=false' \
    /usr/share/osbuild-composer/repositories/almalinux-91.json \
    > /etc/osbuild-composer/repositories/almalinux-91.json
