#!/bin/sh
set -e

# 默认值（如果没有设置环境变量）
VITE_GRAPHQL_URI="${VITE_GRAPHQL_URI:-http://101.37.205.231:8082/graphql}"
VITE_SERVER_URI="${VITE_SERVER_URI:-http://101.37.205.231:8082}"

# 替换 JS 文件中的占位符
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_GRAPHQL_URI_PLACEHOLDER|${VITE_GRAPHQL_URI}|g" {} +
find /usr/share/nginx/html/assets -name '*.js' -exec sed -i "s|__VITE_SERVER_URI_PLACEHOLDER|${VITE_SERVER_URI}|g" {} +

# 启动 nginx
nginx -g 'daemon off;'