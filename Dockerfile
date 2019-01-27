# Tag this phase with a name; makes it clear this is build stage
FROM node:alpine AS builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

# this cmd saves all the important code to /app/build
RUN npm run build

# A second FROM statement tells docker the first phase is done
# and that the second phase is now beginning
FROM nginx
# This line tells Docker that we want to copy data from a
# different phase, in this case "builder", to the static
# html directory for nginx (directory listed from docs)
COPY --from=builder /app/build /usr/share/nginx/html

# The default command for nginx starts the server for us