# Architecture


```text
         HTTPS 443
              │
              ▼
      +---------------+
      |     Nginx     |
      +---------------+
          │      │
  proxy_pass  proxy_pass ...
     │             │
     ▼             ▼
 Homepage      Portainer ...
```

Only Nginx handles HTTPS traffic, while internal container communication uses HTTP.

```text
Root CA
    │
    ├── home.lab
    ├── portainer.lab
    ├── kuma.lab
    ├── pgadmin.lab
    └── swingmusic.lab
```

# Installing and Configuring mkcert on Linux


`mkcert` is a simple tool for making locally-trusted development certificates using its own CA.

Let's create a Certificate Authority (CA):

```text
     Root CA
        │
        │ sign
        ▼
   homelab.pem
        │
        ▼
   Nginx HTTPS
```

## Step 1 - Install mkcert

On Server:

```bash
$ sudo apt update
$ sudo apt install mkcert libnss3-tools -y
```

`libnss3-tools` allows `mkcert` to automatically install the CA in browsers that use the NSS database (like Firefox).

Check installation:

```bash
$ mkcert -version
```

## Step 2 - Create your CA

Now run:

```bash
$ mkcert -install
```

Output:

```text
Created a new local CA
The local CA is now installed in the system trust store!
```

Done! CA created:

```text
Root CA

Private Key
Public Certificate
```

Usually located in:

```bash
$ mkcert -CAROOT

/home/user/.local/share/mkcert
```

Created files:

```bash
rootCA.pem
rootCA-key.pem
```

```text
⚠️ rootCA-key.pem is the private key of your CA. Never share it!
```

## Step 3 - Generate a homelab certificate

Create `certs` folder:

```bash
$ cd ~/homelab/infra/nginx
$ mkdir certs
$ cd certs
```

Now generate a certificate for all services:

```bash
$ mkcert \
-cert-file "../infra/nginx/certs/homelab.pem" \
-key-file "../infra/nginx/certs/homelab-key.pem" \
home.lab \
portainer.lab \
kuma.lab \
pgadmin.lab \
swingmusic.lab
```

The command will generate two files:

```
nginx/
└──certs/
   ├── homelab.pem
   └── homelab-key.pem
```

## Step 4 - Configure the certificates on Nginx

In Nginx `compose.yml` file:

```yaml
volumes:
  - ./conf.d:/etc/nginx/conf.d
  - ./snippets:/etc/nginx/snippets
  - ./certs:/etc/nginx/certs:ro
```

`:ro` (read-only) is a security best practice, as Nginx only needs to read these files.