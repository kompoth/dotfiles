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
    "--config", help="Path to the configuration"
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
        ValueError(f"Can't determine object type: {path}")


def resolve_path(path):
    for var, value in os.environ.items():
        path = path.replace(f"${var}", value)
    return Path(path).resolve()


@app.command()
def deploy(
    config_path: Annotated[str, config_annotation] = "./dottyper.yaml"
):
    cfg = load_config(config_path)

    for directory in cfg.get("symlinks", []):
        target_dir = resolve_path(directory["destination"])
        target_dir.mkdir(parents=True, exist_ok=True)
        for source_file in directory["files"]:
            source_path = resolve_path(source_file)
            target_path = target_dir / source_path.name
            if target_path.exists():
                delete(target_path)
            os.symlink(source_path, target_path)
            print(f"Symlink: {source_path} -> {target_path}")

    for directory in cfg.get("downloads", []):
        target_dir = resolve_path(directory["destination"])
        target_dir.mkdir(parents=True, exist_ok=True)
        for url in directory["urls"]:
            file_name = urlparse(url).path.split("/")[-1]
            resp = requests.get(url, allow_redirects=True)
            open(target_dir / file_name, "wb").write(resp.content)
            print(f"Downloaded: {target_dir / file_name}")

    for directory in cfg.get("repos", []):
        target_dir = resolve_path(directory["destination"])
        for repo in directory["github"]:
            repo_url = "https://github.com/" + repo
            repo_name = repo.split("/")[-1]
            repo_dir = target_dir / repo_name
            if repo_dir.exists():
                print(f"Repo already cloned: {repo}")
            else:
                gitrepo = Repo.clone_from(repo_url, repo_dir)
                print(f"Cloned: {gitrepo.working_tree_dir}")


@app.command()
def clean(
    config_path: Annotated[str, config_annotation] = "./dottyper.yaml"
):
    cfg = load_config(config_path)

    for directory in cfg.get("symlinks", []):
        target_dir = resolve_path(directory["destination"])
        for source_file in directory["files"]:
            source_path = resolve_path(source_file)
            delete(target_dir / source_path.name)

    for directory in cfg.get("downloads", []):
        target_dir = resolve_path(directory["destination"])
        for url in directory["urls"]:
            file_name = urlparse(url).path.split("/")[-1]
            delete(target_dir / file_name)

    for directory in cfg.get("repos", []):
        target_dir = resolve_path(directory["destination"])
        for repo in directory["github"]:
            repo_name = repo.split("/")[-1]
            delete(target_dir / repo_name)


if __name__ == "__main__":
    app()
