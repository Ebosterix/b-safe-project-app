# b-safe-project-app

CI/CD pipeline (Jenkins + Docker + AWS EC2) that automates build, test, and deployment
of a containerized app to a private Docker Hub registry.


## Project Log

- 2026-07-11 Initialized repo structure. Docker Hub private repo created with R/W access token.

- 2026-07-11 Configured Jenkins node `b-safe-project-node` as SSH agent on EC2 (Docker-node instance). Resolved initial connection failure caused by trailing whitespace in "Remote root directory" field.

- 2026-07-11 Installed Docker Pipeline plugin in Jenkins to enable containerized build/push stages in the pipeline.

- 2026-07-12 Wrote Dockerfile (nginx:alpine base). Built and tested locally with Docker Desktop on port 8090 — confirmed app serves correctly at http://localhost:8090.

- 2026-07-12 Wrote smoke_test.sh — builds image, runs container, verifies HTTP 200 + page content, cleans up. Ran locally: PASS.

- 2026-07-12 Created Jenkins credential `dockerhub-creds` (Docker Hub username + access token) for pipeline push stage.

- 2026-07-12 First full Jenkins pipeline run: SUCCESS. All stages passed(Checkout → Build → Test → Push → Deploy → Verify). Image pushed to Docker
  Hub as okile/b-safe-project-app:build-1. App verified reachable via curl on port 8090.

- 2026-07-12 Verified deployed app externally at http://100.31.69.43:8090 — confirmed reachable from public internet, not just localhost. All steps complete.

## Final Evidence
Full documentation of screenshots (Jenkins, Docker Hub, deployed app, terminal outputs)
is available here: [Capstone_assessment_steps.pdf](./docs/evidence/Capstone_assessment_steps.pdf)


## Final Specification Document
[View the full specification document](./docs/B-Safe_Final_Specification_Document.pdf)
