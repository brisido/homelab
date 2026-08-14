# 🏠 My Homelab

Configuration and orchestration files for my personal homelab, focused on self-hosting, automation, and media.


## 🖥️ Hardware & OS

- **Operating System:** Debian 13 (Trixie)
- **Engine Container:** Docker & Docker Compose
- **Architecture:** x86_64


## 🧩 Self-Hosted Services

| Service | Category | Description |
| :--- | :--- | :--- |
| **Nginx** | Network | Reverse proxy and SSL termination |
| **Homepage** | Dashboard | Centralized dashboard for quick access to all services |
| **Portainer** | Dashboard | Graphical management tool to control containerized applications |
| **PostgreSQL** | Database | Open-source relational database management system |
| **pgAdmin** | Dashboard | Graphical management tool for PostgreSQL databases |
| **Uptime Kuma** | Dashboard | Self-hosted monitoring tool to track the health, uptime, and performance of websites, APIs, servers, and network services |
| **Swing Music** | Music Streaming | Self-hosted music streaming server |
| **Jellyfin** | Media Streaming | Self-hosted media server system that lets you host, organize, and stream your own personal collection of movies, TV shows, music, and photos to any device |


## 📁 Directory Structure

```text
.
├── apps/               # Apps configurations and Docker setups
|   ├── swingmusic/
|   └── jellyfin/
├── docs/               # Documentation and guides
├── infra/              # Infrastructure configurations and Docker setups
|   ├── nginx/
|   ├── homepage/
|   ├── portainer/
|   ├── postgres/
|   ├── pgadmin/
|   └── uptime-kuma/
└── scripts/            # Utility and automation scripts
```


## 📚 Documentation

For detailed guides and architecture diagrams, check the `docs/` directory:
- [SSL Certificates](docs/https-configuration/ssl-certificates.md)