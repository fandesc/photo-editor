# 使用官方Node.js运行环境作为基础镜像
FROM node:16-alpine as build-stage

# 设置工作目录
WORKDIR /app

# 复制package.json和package-lock.json
COPY package*.json ./

# 安装依赖
RUN npm install

# 复制项目文件
COPY . .

# 构建Vue应用
RUN npm run build

# 使用Nginx作为生产环境服务器
FROM nginx:alpine

# 将构建好的Vue应用复制到Nginx的默认网站目录中
COPY --from=build-stage /app/dist /usr/share/nginx/html

# 暴露80端口
EXPOSE 80