<h1 align="center">
  <img src="./resources/atom.png" alt="General Web App Icon" width="128" height="128" description="Some atom that represents the app (like the most basic element of some complex system)">
  <div align="center">General Web App</div>
</h1>

<p align="center">
  <a href="https://github.com/Yrrrrrf/quantum">
    <img src="https://img.shields.io/badge/github-quantum-blue?style=for-the-badge&logo=github" alt="GitHub">
  </a>
  <a href="./LICENSE">
    <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="License">
  </a>
  <a>
    <img src="https://img.shields.io/badge/version-0.1.0-blue?style=for-the-badge" alt="Version">
  </a>
</p>

Modern web application blueprint that provides a robust foundation for building sophisticated, data-driven applications. It combines the best practices from both frontend and backend development, offering a complete template that can be customized for various use cases.

## 🛠️ Technology Stack

- **Backend Architecture**:
    - [FastAPI](https://fastapi.tiangolo.com/) for high-performance API development
    - [PostgreSQL](https://www.postgresql.org/) for robust and scalable data storage
- **Frontend Architecture**:
    - [Vite](https://vitejs.dev/) for fast and modern frontend tooling
    - [SvelteKit](https://kit.svelte.dev/) for efficient and reactive web development
        - [DaisyUI](https://daisyui.com/) for responsive and attractive UI components
        - [Tailwind CSS](https://tailwindcss.com/) for utility-first CSS
    - [Tauri](https://tauri.app/) for cross-platform desktop development
- **Development Tools**:
    - [Docker](https://www.docker.com/) for containerization and easy deployment

## 🚦 Getting Started

### Prerequisites

- [Python](https://www.python.org/) (`+3.10`)
- [Node.js](https://nodejs.org/) (`+14.*`)
- [PostgreSQL](https://www.postgresql.org/) (`+13`)
- [Docker](https://www.docker.com/) (*optional, for containerized setup*)

### Installation (Local Setup)

1. Clone the repository
2. Set up the backend
3. Set up the frontend
4. Configure the database
5. Start the development servers

### Docker Setup
`docker-compose up -d`

## 🖥️ Desktop Application

To run the desktop application:

```bash
cd frontend
npm run tauri dev
```

This will start the Tauri development server and launch the desktop application.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
