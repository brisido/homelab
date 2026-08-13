# 🏠 My Homelab

Configuration and orchestration files for my personal homelab, focused on self-hosting, automation, and media.


## 🖥️ Hardware & OS

- **Operating System:** Debian 13 (Trixie)
- **Engine Container:** Docker & Docker Compose
- **Architecture:** x86_64


## 🧩 Self-Hosted Services

| Service | Category | Description |
| :--- | :--- | :--- |
| **Nginx Proxy Manager** | Network | Reverse proxy and SSL certificate manager |
| **Homepage** | Dashboard | Centralized dashboard for quick access to all services |


## 📁 Directory Structure

```text
.
├── docs/               # Documentation and guides
├── infra/              # Infrastructure configurations and Docker setups
|   ├── homepage/
|   └── nginx/
└── scripts/            # Utility and automation scripts
```


## 📚 Documentation

```markdown
For detailed guides and architecture diagrams, check the `docs/` directory:
- [Hardware & Specifications](docs/hardware.md)
- [Network Architecture](docs/architecture.md)
- [Backup & Recovery Strategy](docs/backup-strategy.md)
```