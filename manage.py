import os
from pathlib import Path
from urllib.parse import urlparse
from typing_extensions import Annotated
from git import Repo

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


def delete(path):
    if path.is_symlink():
        path.unlink()
        print(f"Deleted symlink {path}")
    elif path.is_file():
        path.unlink()
        print(f"Deleted file {path}")
    elif path.is_dir():
        for file in path.rglob("*"):
            delete(file)
        path.rmdir()
        print(f"Deleted directory {path}")
    elif not path.exists():
        print(f"Object {path} doesn't exist")
    else:
        ValueError("Can't determine object type: {path}")


def resolve_path(path):
    for var, value in os.environ.items():
        path = path.replace(f"${var}", value)
    return Path(path).resolve()


@app.command()
def deploy(
    config_path: Annotated[str, config_annotation] = "./config_manage.yml"
):
    cfg = load_config(config_path)

    for destination in cfg.get("destinations", []):
        target = resolve_path(destination["target_dir"])
        source = resolve_path(destination["source_dir"])
        target.mkdir(parents=True, exist_ok=True)
        for file in destination["files"]:
            path = target / file
            if path.exists():
                delete(path)
            os.symlink(source / file, target / file)
            print(f"Symlink: {(target / file)} -> {(source / file)}")

    for load in cfg.get("downloads", []):
        target = resolve_path(load["target_dir"])
        target.mkdir(parents=True, exist_ok=True)
        url = load["url"]
        file = urlparse(url).path.split("/")[-1]
        resp = requests.get(url, allow_redirects=True)
        open(target / file, "wb").write(resp.content)
        print(f"Downloaded: {target / file}")

    for repo in cfg.get("repos", []):
        target = resolve_path(repo["target_dir"])
        url = repo["url"]
        if target.exists():
            print(f"Repo exists: {target}")
        else:
            gitrepo = Repo.clone_from(url, target)
            print(f"Cloned: {gitrepo.working_tree_dir}")


@app.command()
def clean(
    config_path: Annotated[str, config_annotation] = "./config_manage.yml"
):
    cfg = load_config(config_path)

    for destination in cfg.get("destinations", []):
        target = resolve_path(destination["target_dir"])
        for file in destination["files"]:
            delete(target / file)

    for load in cfg.get("downloads", []):
        target = resolve_path(load["target_dir"])
        file = urlparse(load["url"]).path.split("/")[-1]
        delete(target / file)

    for repo in cfg.get("repos", []):
        target = resolve_path(repo["target_dir"])
        delete(target)


if __name__ == "__main__":
    app()
