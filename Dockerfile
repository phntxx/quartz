FROM node:22-slim as builder
WORKDIR /app
COPY package.json .
COPY package-lock.json* .
RUN npm ci

FROM node:22-slim
WORKDIR /app
COPY --from=builder /app/ /app/
COPY . .

ENV DIRECTORY "content"
ENV OUTPUT "public"
ENV BASE_DIR ""
ENV FAST_REBUILD "false"
ENV PORT "8080"
ENV WS_PORT "3001"
ENV REMOTE_HOST ""

EXPOSE 8080
EXPOSE 3001

CMD npx quartz build -d $DIRECTORY -o $OUTPUT --fastRebuild $FAST_REBUILD --baseDir $BASE_DIR --port $PORT --wsPort $WS_PORT --remoteDevHost $REMOTE_HOST --serve
