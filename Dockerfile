FROM node:22-alpine AS build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

# 构建时使用占位符
RUN VITE_GRAPHQL_URI=__VITE_GRAPHQL_URI_PLACEHOLDER_ VITE_SERVER_URI=__VITE_SERVER_URI_PLACEHOLDER_ npm run build -- --mode production

FROM nginx:alpine AS production-stage
COPY nginx-custom.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /app/dist /usr/share/nginx/html
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
EXPOSE 80