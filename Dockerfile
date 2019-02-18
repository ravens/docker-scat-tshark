FROM alpine:3.9
RUN apk add --no-cache python3 py-pip build-base git libusb tshark
RUN pip3 install pyserial pyusb
RUN git clone https://github.com/fgsect/scat.git /root/scat
WORKDIR /root/scat
COPY scat.patch .
RUN patch -p1 < scat.patch
