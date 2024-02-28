from typing_extensions import Annotated
from git import Repo
from typer import Typer, Option
import requests
import os

from .config import Config
from .utils import delete

app = Typer()
config_annotation = Annotated[str, Option(help="Path to the configuration")]


@app.command()
def deploy(
    config: config_annotation = "./dottyper.yaml",
    force: Annotated[bool, Option(help="Overwrite existing files")] = False,
    verbose: Annotated[bool, Option(help="Print detailed output")] = False
):
    cfg = Config(config)

    for source, target in cfg.get_symlinks():
        if target.exists():
            if force:
                delete(target)
            else:
                continue
        target.parents[0].mkdir(parents=True, exist_ok=True)
        os.symlink(source, target)
        print(f"Symlink created: {target}")

    for url, target in cfg.get_downloads():
        # TODO use aiohttp
        if target.exists() and not force:
            continue
        target.parents[0].mkdir(parents=True, exist_ok=True)
        resp = requests.get(url, allow_redirects=True)
        open(target, "wb").write(resp.content)
        print(f"Downloaded file: {target}")

    for url, target in cfg.get_repos():
        target.parents[0].mkdir(parents=True, exist_ok=True)
        # TODO tags and specific commits
        # TODO gitlab support
        # TODO can we make it async?
        if target.exists():
            if force:
                delete(target)
            else:
                continue
        gitrepo = Repo.clone_from(url, target)
        print(f"Repo cloned: {gitrepo.working_tree_dir}")


@app.command()
def clean(
    config: config_annotation = "./dottyper.yaml",
    verbose: Annotated[bool, Option(help="Print detailed output")] = False
):
    cfg = Config(config)

    for source, target in cfg.get_symlinks():
        delete(target)
        print(f"Deleted {target}")

    for url, target in cfg.get_downloads():
        delete(target)
        print(f"Deleted {target}")

    for url, target in cfg.get_repos():
        delete(target)
        print(f"Deleted {target}")


if __name__ == "__main__":
    app()
