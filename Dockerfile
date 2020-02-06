FROM runmymind/docker-android-sdk

ENV FLUTTER_CHANNEL=beta
ENV FLUTTER_VERSION=1.14.6-${FLUTTER_CHANNEL}

RUN bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
RUN wget --quiet --output-document=flutter.tar.xz https://storage.googleapis.com/flutter_infra/releases/${FLUTTER_CHANNEL}/linux/flutter_linux_v${FLUTTER_VERSION}.tar.xz \
	&& tar xf flutter.tar.xz -C / \
	&& rm flutter.tar.xz

RUN apt-get update && apt-get install -y lcov

ENV PATH=$PATH:/flutter/bin

RUN bash -c 'yes | tools/bin/sdkmanager --licenses'

RUN flutter config --enable-web
    
RUN flutter doctor
