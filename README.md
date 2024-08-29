<a id="readme-top"></a>

<div align="center">
<h3 align="center">Traefik local proxy</h3>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
  </ol>
</details>

## About The Project

The goal is to be able to run you website locally using HTTPS. We use traefik and a self-signed certificate to achieve this. By just assigning labels to your docker containers, you can have a local proxy that will route your requests to the correct container.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Getting Started
### Prerequisites

* `Docker`
* `Make`

### Installation

1. Clone the repo
   ```sh
   git clone https://github.com/Te4g/treafik-local-proxy.git
   ```
2. Optional: you can change the domain used in the `cert.conf` file, default is `dev.localhost`
3. Run `make install`
4. Run `make start`

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Usage
Once this project is running, you can then start your other projects by adding to your `compose.yaml` file some labels:

/!\ Be careful to only use a **third level domain**, like `my-project-name.dev.localhost` and not `api.my-project-name.dev.localhost` or `my-project-name.localhost`

```yaml
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.my-project-name.rule=Host(`my-project-name.dev.localhost`)"
      - "traefik.http.routers.my-project-name.entrypoints=websecure"
      - "traefik.http.routers.my-project-name.tls=true"
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>
