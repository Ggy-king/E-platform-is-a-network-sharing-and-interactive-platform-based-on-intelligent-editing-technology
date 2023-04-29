FROM rust
COPY . /app 
WORKDIR /app

RUN apt-get update \
# python jina 构建 
&& apt-get install python3.9 pip ffmpeg nodejs npm -y \
&& pip install -r ./hello-jina2/requirements.txt \
&& pip install git+https://github.com/openai/CLIP.git \
# yarn
&& npm i yarn -g \
# 前端构建
&& cd pick && yarn && yarn build \
# python 软链接
&& cd /usr/bin && ln -s python3 python 

# container
EXPOSE 3001
CMD ["node", "./pick/dist/main"]
