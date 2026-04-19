FROM node:18-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

# ✅ Force npm to use writable location
RUN npm config set cache /tmp/.npm --global

# ✅ OpenShift permission fix
RUN chgrp -R 0 /app /tmp && chmod -R g+rwX /app /tmp

# ✅ Ensure app binds externally
ENV HOST=0.0.0.0

EXPOSE 3000

CMD ["npm", "start"]
