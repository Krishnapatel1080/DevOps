# ---------- Stage 1: Build ----------
FROM node:24-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

RUN npm run build


# ---------- Stage 2: Production ----------
FROM node:24-alpine

RUN npm install -g serve

WORKDIR /app

COPY --from=build /app/dist ./build

EXPOSE 3000

CMD ["serve", "build", "-l", "3000"]

