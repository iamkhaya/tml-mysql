FROM mysql:8

LABEL Maintainer="dev@thumela.co.zw"

# set environment varibles
ENV TZ=Africa/Johannesburg
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

WORKDIR /usr/local/thumela

COPY . .
