FROM debian:stable

ENV PATH="/root/.cargo/bin:${PATH}"
RUN apt update -y && apt install -y gcc curl gcc-arm-linux-gnueabihf
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
RUN echo "[target.armv7-unknown-linux-gnueabihf]" > /root/.cargo/config
RUN echo "linker = \"/usr/bin/arm-linux-gnueabihf-gcc\"" >> /root/.cargo/config
RUN rustup target add armv7-unknown-linux-gnueabihf
