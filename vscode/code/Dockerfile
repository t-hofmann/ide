FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "installing prerequisites" \
	&& apt-get update \
    && apt-get install -y --no-install-recommends \
        apt-transport-https \
    	ca-certificates \
        curl \
        gpg \
        libasound2 \
        libx11-xcb1 \
        procps \
        sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

	    # git \
		# golang-go \

WORKDIR /root

RUN echo "adding vscode-deb-repository" \
    && curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

RUN echo "installing vscode" \
    && apt-get update \
    && apt-get install -y code

WORKDIR /

COPY ./fs_root/. /.

# code --list-extensions
# code --install-extension ms-vscode.cpptools
# code --uninstall-extension ms-vscode.csharp
