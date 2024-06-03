from typing_extensions import Annotated
from typer import Typer, Option
import requests
import os

from .config import Config

app = Typer()
config_annotation = Annotated[str, Option(help="Path to the configuration")]


def delete(path):
    if path.is_symlink() or path.is_file():
        path.unlink()
    if path.is_dir():
        for file in path.rglob("*"):
            delete(file)
        path.rmdir()
    elif not path.exists():
        # TODO some logging
        pass
    else:
        ValueError(f"Can't determine object type: {path}")


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


if __name__ == "__main__":
    app()
