#FROM python:3
FROM continuumio/anaconda3

WORKDIR /home

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get install -y ca-certificates && \
    apt-get install -y openssl && \
    apt-get install -y g++ && \
    apt-get install -y cmake && \
	apt-get install -y zsh && \
	apt-get install -y nano && \
    apt-get clean && \
    chsh -s /usr/bin/zsh

ADD ./ivz-common-debian.sh ./config_zsh.sh ./zsh_plugins.txt ./.p10k.zsh ./p10kheader.txt ./p10kfooter.txt ./.vimrc ./config_vim.sh ./vim_plugins.txt ./

RUN chmod -R 777 ./ && \
    ./ivz-common-debian.sh && \
    update-ca-certificates && \
    ./config_zsh.sh && \ 
    ./config_vim.sh


#RUN chmod 777 ./ivz-common-debian.sh && ./ivz-common-debian.sh && update-ca-certificates

CMD ["zsh"]
