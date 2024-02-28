from typing_extensions import Annotated
from git import Repo
import typer
import requests
import os

from .config import Config

app = typer.Typer()
config_annotation = typer.Option(
    "--config", help="Path to the configuration"
)


# TODO move to utils
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


@app.command()
def deploy(
    config_path: Annotated[str, config_annotation] = "./dottyper.yaml"
):
    cfg = Config(config_path)

    for source, target in cfg.get_symlinks():
        # TODO if exists: default - warn and continue; force - overwrite
        if target.exists():
            delete(target)
        target.parents[0].mkdir(parents=True, exist_ok=True)
        os.symlink(source, target)
        print(f"Symlink: {source} -> {target}")

    for url, target in cfg.get_downloads():
        # TODO if exists: default - warn and continue; force - overwrite
        # TODO use aiohttp
        target.parents[0].mkdir(parents=True, exist_ok=True)
        resp = requests.get(url, allow_redirects=True)
        open(target, "wb").write(resp.content)
        print(f"Downloaded: {target}")

    for url, target in cfg.get_repos():
        target.parents[0].mkdir(parents=True, exist_ok=True)
        # TODO if exists: default - warn and continue; force - pull
        # TODO tags and specific commits
        # TODO gitlab support
        # TODO can we make is async?
        if target.exists():
            print(f"Repo already cloned: {url}")
        else:
            print(f"Cloning: {url}")
            gitrepo = Repo.clone_from(url, target)
            print(f"Cloned: {gitrepo.working_tree_dir}")


@app.command()
def clean(
    config_path: Annotated[str, config_annotation] = "./dottyper.yaml"
):
    cfg = Config(config_path)

    for source, target in cfg.get_symlinks():
        delete(target)

    for url, target in cfg.get_downloads():
        delete(target)

    for url, target in cfg.get_repos():
        delete(target)


if __name__ == "__main__":
    app()
