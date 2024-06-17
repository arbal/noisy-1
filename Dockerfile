FROM cgr.dev/chainguard/python:latest-dev@sha256:a66967d781bec4367589c4e9b98c18e3df0f24c38c380e45af383a3424b34bde as builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt --user
FROM cgr.dev/chainguard/python:latest@sha256:73d190f98ad153222ec562056fd8afd710b0d513d6015672e6198046978942f3
WORKDIR /app

# Make sure you update Python version in path
COPY --from=builder /home/nonroot/.local/lib/python3.12/site-packages /home/nonroot/.local/lib/python3.12/site-packages

COPY . .

ENTRYPOINT [ "python", "/app/noisy.py", "--config", "/app/config.json"]