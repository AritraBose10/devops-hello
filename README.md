# devops-hello

Demo app for the DevOps practical class *Code to Container to Cloud*.

| File | Purpose |
| --- | --- |
| `app.py` | Flask app with `/` and `/healthz` |
| `tests/test_app.py` | Unit test run by CI |
| `Dockerfile` | Container image (non-root user, gunicorn on port 8080) |
| `.github/workflows/ci.yml` | Tests and builds the image on every push and pull request |
| `render.yaml` | Render Blueprint: deploys the free web service |
| `k8s-demo.sh` | Instructor only: local Kubernetes demo with kind, inside a Codespace |

## Run locally

```bash
pip install -r requirements.txt pytest
python -m pytest -q
python -m flask --app app run --port 8080
```

## Instructor rehearsal (no credit card needed)

1. **Render:** sign in at render.com with GitHub, then New -> Blueprint -> this repo. Open the `onrender.com` URL it gives.
2. **Kubernetes:** open this repo in a Codespace and run `bash k8s-demo.sh`.
