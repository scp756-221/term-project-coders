FROM ghcr.io/scp756-221/c756-tool:v1.0beta4
#
# Install Google gcloud---but as of Dec 2021, only on x86_64 linux,
# not aarch64 Linux.
# See https://cloud.google.com/sdk/docs/downloads-versioned-archives
# for the list of available distributions.
#

ARG ARCH_CLASS="x86_64"

# The "if" statement uses bash syntax
SHELL ["/usr/bin/bash", "-c"]
# See https://cloud.google.com/sdk/docs/install#deb
# for explanation of this sequence.
RUN if [[ "${ARCH_CLASS}" == "x86_64" ]]; then \
   echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" \
|  tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
&& curl https://packages.cloud.google.com/apt/doc/apt-key.gpg \
|  apt-key --keyring /usr/share/keyrings/cloud.google.gpg  add - \
&& apt-get update -y \
&& apt-get install google-cloud-sdk -y \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* \
;  fi

# `~/.config/gcloud` config directory is already
# mapped in as subdirectory of `~/.config`

# By default, run a login shell that reads `.profile`
CMD ["bash", "-l"]