FROM continuumio/anaconda3

WORKDIR /home

COPY package_list.txt ./
RUN apt-get update && \
    xargs apt-get install -y <package_list.txt && \
    apt-get clean && \
    chsh -s /usr/bin/zsh

ADD ./ivz-common-debian \
    ./config_conda.sh \
    ./config_conda_envs.sh \
    ./py-env.yml \
    ./py-env-condarc \
    ./snowflake-env.yml \
    ./snowflake-env-condarc \
    ./

RUN chmod -R 777 ./ && \
    ./ivz-common-debian && \
    update-ca-certificates && \
    ./config_conda.sh && \
    ./config_conda_envs.sh

CMD ["zsh"]
