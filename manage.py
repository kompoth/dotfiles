import os
import errno
from pathlib import Path
from urllib.parse import urlparse
from typing_extensions import Annotated

import typer
import yaml
import requests

app = typer.Typer()
config_annotation = typer.Option(
    "--config", help="Config path"
)


def load_config(config_path):
    with open(config_path, "r") as fd:
        cfg = yaml.safe_load(fd)
    return cfg


def silent_delete(path):
    try:
        os.remove(path)
    except OSError as ex:
        if ex.errno != errno.ENOENT:
            raise ex


def resolve_path(path):
    for var, value in os.environ.items():
        path = path.replace(f"${var}", value)
    return Path(path).resolve()


@app.command()
def deploy(
    config_path: Annotated[str, config_annotation] = "./config_manage.yml"
):
    cfg = load_config(config_path)
    for destination in cfg["destinations"]:
        target = resolve_path(destination["target_dir"])
        source = resolve_path(destination["source_dir"])
        target.mkdir(parents=True, exist_ok=True)
        for file in destination["files"]:
            silent_delete(target / file)
            os.symlink(source / file, target / file)
            print(f"Symlink: {(target / file)} -> {(source / file)}")
    for load in cfg["downloads"]:
        target = resolve_path(load["target_dir"])
        target.mkdir(parents=True, exist_ok=True)
        url = load["url"]
        file = urlparse(url).path.split("/")[-1]
        resp = requests.get(url, allow_redirects=True)
        open(target / file, "wb").write(resp.content)
        print(f"Downloaded: {target / file}")


@app.command()
def clean(
    config_path: Annotated[str, config_annotation] = "./config_manage.yml"
):
    cfg = load_config(config_path)
    for destination in cfg["destinations"]:
        target = resolve_path(destination["target_dir"])
        for file in destination["files"]:
            silent_delete(target / file)
            print(f"Removed: {target / file}")
    for load in cfg["downloads"]:
        target = resolve_path(load["target_dir"])
        file = urlparse(load["url"]).path.split("/")[-1]
        silent_delete(target / file)
        print(f"Removed: {target / file}")


if __name__ == "__main__":
    app()
