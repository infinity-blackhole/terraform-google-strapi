FROM docker.io/library/node@sha256:4100e31b8e6fc9bdfbceab1cbbc85f4b493888d3d8f1fda5b2d7469bb3da056d AS base

# Install GYP depedencies
RUN apt-get update -y && apt-get install -y python3

# Define the current directory based on defacto community standard
WORKDIR /usr/src/app

FROM base AS deps

# Pull all depedencies
COPY package.json package-lock.json ./
RUN npm ci --production

FROM deps AS source

# Copy source
COPY . .

FROM source

# Build application
ENV NODE_ENV=production
RUN npm run build

# Switch to the node default non-root user
USER node

# Default HTTP Port
EXPOSE 1337

# Production entrypoint
CMD [ "npm", "run", "start" ]
