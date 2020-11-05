# Docker File w/ Multi-Steps

# Step 1: Build Phase
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# Creates build folder under /app folder
RUN npm run build 

# Step 2: Run Phase, uses different base image 
FROM nginx
# --from=0, from first stage (build phase for this file)
# /usr/share/nginx/html is specific to nginx static hosting server
COPY --from=0 /app/build /usr/share/nginx/html