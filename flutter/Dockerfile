FROM ubuntu:20.04

ENV UID=1000
ENV GID=1000
ENV USER="developer"

ENV JAVA_VERSION="11"
ENV ANDROID_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip"
ENV ANDROID_VERSION="31"
# 33.0.3
ENV ANDROID_BUILD_TOOLS_VERSION="30.0.3" 
ENV ANDROID_ARCHITECTURE="x86_64"
ENV ANDROID_SDK_ROOT="/home/$USER/android"

ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.3.3"
ENV FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz"
ENV FLUTTER_HOME="/home/$USER/flutter"
ENV FLUTTER_WEB_PORT="8090"
ENV FLUTTER_DEBUG_PORT="42000"

ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/platforms:$FLUTTER_HOME/bin:$PATH"

# install all dependencies
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update \
    && apt-get install --yes --no-install-recommends openjdk-$JAVA_VERSION-jdk curl unzip sed git bash xz-utils libglvnd0 ssh xauth x11-xserver-utils libpulse0 libxdamage1 libxcomposite1 libgl1-mesa-glx sudo \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

# create user
RUN groupadd --gid $GID $USER \
    && useradd -s /bin/bash --uid $UID --gid $GID -m $USER \
    && echo $USER ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USER \
    && chmod 0440 /etc/sudoers.d/$USER

USER $USER
WORKDIR /home/$USER

# android sdk
RUN mkdir -p $ANDROID_SDK_ROOT \
    && mkdir -p /home/$USER/.android \
    && touch /home/$USER/.android/repositories.cfg \
    && curl -o android_tools.zip $ANDROID_TOOLS_URL \
    && unzip -qq -d "$ANDROID_SDK_ROOT/cmdline-tools" android_tools.zip \
    && rm android_tools.zip 
    
# move android sdk folder
RUN mv $ANDROID_SDK_ROOT/cmdline-tools/cmdline-tools $ANDROID_SDK_ROOT/cmdline-tools/latest

# sdkmanager install basic packages
RUN yes "y" | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
    && yes "y" | sdkmanager "platforms;android-$ANDROID_VERSION" \
    && yes "y" | sdkmanager "platform-tools" \
    && yes "y" | sdkmanager "emulator" \
    && yes "y" | sdkmanager "system-images;android-$ANDROID_VERSION;google_apis_playstore;$ANDROID_ARCHITECTURE"

# download flutter
RUN curl -o flutter.tar.xz $FLUTTER_URL \
    && mkdir -p $FLUTTER_HOME \
    && tar xf flutter.tar.xz -C /home/$USER \
    && rm flutter.tar.xz

ENV FLUTTER_EMULATOR_NAME="flutter_emulator"

# init flutter
RUN flutter config --no-analytics \
    && flutter precache \
    && yes "y" | flutter doctor --android-licenses \
    && flutter emulators --create --name $FLUTTER_EMULATOR_NAME \
    && flutter doctor -v \
    && flutter update-packages

# Gradle
# COPY ./src  /home/developer/flutter_app
# RUN cd ./flutter_app/android && ./gradlew

# ENV GRADLE_VERSION=gradle-7.5.1
# ENV GRADLE_HOME=/home/$USER/$GRADLE_VERSION
# ENV PATH=$PATH:$GRADLE_HOME/bin

# RUN curl -L https://services.gradle.org/distributions/$GRADLE_VERSION-bin.zip -o $GRADLE_VERSION-bin.zip \
#   && unzip $GRADLE_VERSION-bin.zip \
#   && rm $GRADLE_VERSION-bin.zip

# RUN echo 'export GRADLE_HOME=/app/$GRADLE_VERSION' >> $HOME/.bashrc
# RUN echo 'export PATH=$PATH:$GRADLE_HOME/bin' >> $HOME/.bashrc
# RUN /bin/bash -c "source $HOME/.bashrc"
# RUN gradle test jar


COPY ./scripts/chown.sh /usr/local/bin/
COPY ./scripts/flutter-android-run.sh /usr/local/bin/flutter-android-run
# COPY ./scripts/flutter-android-emulator.sh /usr/local/bin/flutter-android-emulator
# COPY ./scripts/flutter-android-usb.sh /usr/local/bin/flutter-android-usb

USER root
RUN chmod +x /usr/local/bin/chown.sh \
    && chmod +x /usr/local/bin/flutter-android-run

USER $USER