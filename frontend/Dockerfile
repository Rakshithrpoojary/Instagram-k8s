FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json .

RUN npm ci --omit=dev
COPY . .
ARG REACT_APP_BACKEND_URL
ENV REACT_APP_BACKEND_URL=$REACT_APP_BACKEND_URL
RUN npm run build

FROM nginxinc/nginx-unprivileged

COPY --from=builder /app/build /usr/share/nginx/html
EXPOSE 80

CMD ["nginx","-g","daemon off;"]