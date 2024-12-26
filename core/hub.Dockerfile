FROM node:20-alpine

# Set the working directory in the container
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy all files from the current directory to the container
COPY . .

# Expose port 5173 for Vite's development server
EXPOSE 5173

# Command to run the development server
CMD ["npm", "run", "dev", "--", "--host", "0.0.0.0"]

# todo: Somehow do the same but using 'bun'
# ^ The container must have all but the 'src-tauri' directory
# ^ The 'src-tauri' directory must be mounted from the host machine
