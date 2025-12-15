FROM node:lts-alpine

# 安装 tini
RUN apk add --no-cache tini

ENV NODE_ENV=production

# 使用 node 用户（保持你的安全模型）
USER node

WORKDIR /app

# 先复制依赖描述文件和 npm 配置（关键）
COPY --chown=node:node package.json ./
COPY --chown=node:node .npmrc ./

# 安装依赖（生产环境常用参数）
RUN npm install --no-audit --progress=false

# 再复制其余源码
COPY --chown=node:node . .

EXPOSE 7777

CMD ["/sbin/tini", "--", "node", "app.js"]

# FROM node:lts-alpine

# RUN apk add --no-cache tini

# ENV NODE_ENV production

# USER node

# WORKDIR /app

# COPY --chown=node:node . ./

# RUN yarn --network-timeout=100000

# EXPOSE 7777

# CMD [ "/sbin/tini", "--", "node", "app.js" ]
