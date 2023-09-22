FROM docker.io/almalinux/9-init:9.2-20230718

RUN dnf -qy upgrade \
 && dnf -qy install \
       composer-cli \
       jq \
       lorax-templates-almalinux \
       osbuild-composer \
       scap-security-guide \
 && dnf clean all \
 && systemctl enable osbuild-composer.socket \
 && mkdir -p /etc/osbuild-composer/{repositories,oscap} \
 && jq 'del(.[][].gpgkey) | .[][].check_gpg=false' \
    /usr/share/osbuild-composer/repositories/almalinux-91.json \
    > /etc/osbuild-composer/repositories/almalinux-91.json

COPY xccdf_ch.hairmare.content_profile_cis_light.xml /etc/osbuild-composer/oscap/
