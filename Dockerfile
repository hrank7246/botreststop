FROM python:3.13-slim

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY server.py .

# 글과 방문 기록이 담기는 파일은 /data 에 둡니다. 이 폴더는 꼭 지워지지 않는 저장 공간(볼륨)에 연결하세요.
ENV SHIMTEO_HOST=0.0.0.0 \
    SHIMTEO_PORT=8000 \
    SHIMTEO_DB=/data/shimteo.db \
    SHIMTEO_TRUST_PROXY=1
VOLUME /data
EXPOSE 8000

CMD ["python", "server.py"]
