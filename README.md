# devops-hello

Demo app for the DevOps practical class *Code to Container to Cloud*.

| File | Purpose |
| --- | --- |
| `app.py` | Flask app with `/` and `/healthz` |
| `tests/test_app.py` | Unit test run by CI |
| `Dockerfile` | Container image (non-root user, gunicorn on port 8080) |
| `.github/workflows/ci.yml` | Tests and builds the image on every push and pull request |
| `rehearse.sh` | Instructor only: deploys to Cloud Run from Cloud Shell |

## Run locally

```bash
pip install -r requirements.txt pytest
python -m pytest -q
python -m flask --app app run --port 8080
```

## Instructor rehearsal (Cloud Shell)

```bash
git clone https://github.com/YOUR-USER/devops-hello && cd devops-hello
bash rehearse.sh YOUR-PROJECT-ID
```
