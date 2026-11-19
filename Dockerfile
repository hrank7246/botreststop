FROM python:3.13-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY server.py .

# 글과 방문 기록이 담기는 파일은 /data 에 둡니다. 호스팅에서 지워지지 않는 저장 공간(볼륨)을 /data 에 연결하세요.
# (Railway 는 Dockerfile 의 VOLUME 줄을 받지 않으므로 여기에는 적지 않습니다.)
RUN mkdir -p /data
ENV SHIMTEO_HOST=0.0.0.0 \
    SHIMTEO_DB=/data/shimteo.db \
    SHIMTEO_TRUST_PROXY=1
EXPOSE 8000

# 포트는 호스팅이 정해 주는 PORT 를 따르고, 없으면 8000 을 씁니다.
CMD ["python", "server.py"]
