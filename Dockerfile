# Stage 1: Build Angular application
FROM node:22-alpine AS builder

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build Angular application
RUN npm run build

# Stage 2: Serve with nginx
FROM nginx:alpine

# Copy built application from builder
COPY --from=builder /app/dist/ng-new-starter/browser /usr/share/nginx/html

# Copy nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
