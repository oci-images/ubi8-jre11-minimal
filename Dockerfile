# ------------------------------------------------------------------------------
#          NOTE: THIS DOCKERFILE IS GENERATED FOR OCI IMAGES PROJECT
#
#                       PLEASE DO NOT EDIT IT DIRECTLY.
# ------------------------------------------------------------------------------
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

FROM registry.access.redhat.com/ubi8/ubi-minimal:8.4

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

EXPOSE 8080 8443 8778

RUN microdnf install -y tzdata openssl curl ca-certificates fontconfig glibc-langpack-en gzip tar \
    && microdnf update -y; microdnf clean all

LABEL name="ubi-jre11-minimal" \
      vendor="Oci-Images-Project" \
      version="jdk-11.0.11+9" \
      release="11" \
      run="docker run --rm -ti <image_name:tag> /bin/bash" \
      summary="AdoptOpenJDK OCI Image for OpenJDK with hotspot and ubi-minimal for runs Java applications" \
      description="For more information on this image please see https://github.com/DemonAzteck/oci-images/tree/main/java/runner"

ENV JAVA_VERSION jdk-11.0.11+9

RUN set -eux; \
    ARCH="$(uname -m)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='fde6b29df23b6e7ed6e16a237a0f44273fb9e267fdfbd0b3de5add98e55649f6'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11%2B9/OpenJDK11U-jre_aarch64_linux_hotspot_11.0.11_9.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='37c19c7c2d1cea627b854a475ef1a765d30357d765d20cf3f96590037e79d0f3'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11%2B9/OpenJDK11U-jre_ppc64le_linux_hotspot_11.0.11_9.tar.gz'; \
         ;; \
       s390x) \
         ESUM='f18101fc50aad795a41b4d3bbc591308c83664fd2390bf2bc007fd9b3d531e6c'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11%2B9/OpenJDK11U-jre_s390x_linux_hotspot_11.0.11_9.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='144f2c6bcf64faa32016f2474b6c01031be75d25325e9c3097aed6589bc5d548'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.11%2B9/OpenJDK11U-jre_x64_linux_hotspot_11.0.11_9.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -kLfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
	mkdir -p /opt/app; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;
COPY java_runner.sh /opt/app
ENV JAVA_HOME=/opt/java/openjdk \
	JAVA_OPTIONS=\
	JAVA_ARGS=\
    PATH="/opt/java/openjdk/bin:$PATH"
WORKDIR /opt/app
COPY java_runner.sh /opt/app
CMD ["/bin/bash","/opt/app/java_runner.sh","run"]