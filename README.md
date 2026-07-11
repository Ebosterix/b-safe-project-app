# b-safe-project-app

CI/CD pipeline (Jenkins + Docker + AWS EC2) that automates build, test, and deployment
of a containerized app to a private Docker Hub registry.


## Project Log

- 2026-07-11 Initialized repo structure. Docker Hub private repo created with R/W access token.

- 2026-07-11 Configured Jenkins node `b-safe-project-node` as SSH agent on EC2 (Docker-node instance). Resolved initial connection failure caused by trailing whitespace in "Remote root directory" field.
