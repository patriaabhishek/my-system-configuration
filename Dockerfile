#FROM python:3
FROM continuumio/anaconda3

WORKDIR /home

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY package_list.txt ./
RUN apt-get update && \
    xargs apt-get install -y <package_list.txt && \
    apt-get clean && \
    chsh -s /usr/bin/zsh

# RUN apt-get update && \
#     apt-get install -y wget && \
#     apt-get install -y curl && \
#     apt-get install -y ca-certificates && \
#     apt-get install -y openssl && \
#     apt-get install -y g++ && \
#     apt-get install -y cmake && \
# 	apt-get install -y zsh && \
# 	apt-get install -y nano && \
#     apt-get clean && \
#     chsh -s /usr/bin/zsh

ADD ./ivz-common-debian.sh \
    ./config_zsh.sh \
    ./zsh_plugins.txt \
    ./.p10k.zsh \
    ./p10kheader.txt \
    ./p10kfooter.txt \
    ./.vimrc \
    ./config_vim.sh \
    ./vim_plugins.txt \
    ./config_nano.sh \
    ./

RUN chmod -R 777 ./ && \
    ./ivz-common-debian.sh && \
    update-ca-certificates && \
    ./config_zsh.sh && \
    ./config_vim.sh && \
    ./config_nano.sh

CMD ["zsh"]
