FROM debian:12

ENV PATH="/root/.cargo/bin:${PATH}"
RUN apt update -y && apt install -y gcc curl gcc-aarch64-linux-gnu
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | bash -s -- -y
RUN echo "[target.aarch64-unknown-linux-gnu]" > /root/.cargo/config
RUN echo "linker = \"/usr/bin/aarch64-linux-gnu-gcc\"" >> /root/.cargo/config
RUN rustup target add aarch64-unknown-linux-gnu
