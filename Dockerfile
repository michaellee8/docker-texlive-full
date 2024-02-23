FROM ubuntu:latest

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends wget gzip ca-certificates perl

RUN mkdir -p /src/texlive-full \
    && cd /src/texlive-full \
    && wget https://ctan.org/tex-archive/systems/texlive/tlnet/install-tl-unx.tar.gz \
    && zcat < install-tl-unx.tar.gz | tar xf - \
    && cd install-tl-* \
    && perl ./install-tl --no-interaction \
    && distprefix=$(echo /usr/local/texlive/*/texmf-dist) \
    && binprefix=$(echo /usr/local/texlive/*/bin) \
    && binpath="${binprefix}/bin/"$(uname -p)"-linux" \
    && ln -s "${binpath}" "${binprefix}/currentarch-linux" \
    && ln -s "${binprefix}/currentarch-linux" "/usr/local/texlive/currentversion-currentarch-linux-bin" \
    && ln -s "${distprefix}" "/usr/local/texlive/currentversion-dist"

ENV PATH=$PATH:/usr/local/texlive/currentversion-currentarch-linux-bin
ENV MANPATH=$MANPATH:/usr/local/texlive/currentversion-dist/doc/man
ENV INFOPATH=$INFOPATH:/usr/local/texlive/currentversion-dist/doc/info

RUN latex --version