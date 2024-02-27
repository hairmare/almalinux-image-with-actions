FROM docker.io/almalinux/9-init:9.3

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
    /usr/share/osbuild-composer/repositories/almalinux-93.json \
    > /etc/osbuild-composer/repositories/almalinux-93.json \
 && cp /usr/lib/osbuild/runners/org.osbuild.centos9 /usr/lib/osbuild/runners/org.osbuild.almalinux

COPY xccdf_ch.hairmare.content_profile_cis_light.xml /etc/osbuild-composer/oscap/
