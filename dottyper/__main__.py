import asyncio
import os
from pathlib import Path

import httpx
from typer import Option, Typer
from typing_extensions import Annotated

from .config import Config

app = Typer()
config_annotation = Annotated[str, Option(help="Path to the configuration")]
progress = {"done": 0, "total": 0}


def log_progress(message: str) -> None:
    progress["done"] += 1
    progress_str = f"[{progress['done']}/{progress['total']}]"
    print(f"{progress_str:>10s}", message)


def delete(path: Path) -> None:
    if path.is_symlink() or path.is_file():
        path.unlink()
    if path.is_dir():
        for file in path.rglob("*"):
            delete(file)
        path.rmdir()
    elif not path.exists():
        pass
    else:
        ValueError(f"Can't determine object type: {path}")


async def async_download_all(downloads) -> None:
    tasks = set()
    async with httpx.AsyncClient() as client:
        for url, destination in downloads:
            tasks.add(asyncio.create_task(
                async_download_file(client, url, destination)
            ))
        for coro in asyncio.as_completed(tasks):
            await coro


async def async_download_file(client, url, destination) -> None:
    destination.parents[0].mkdir(parents=True, exist_ok=True)
    resp = await client.get(url, follow_redirects=True)
    open(destination, "wb").write(resp.content)
    log_progress(f"File downloaded: {destination}")


@app.command()
def deploy(
    config: config_annotation = "./dottyper.yaml",
    force: Annotated[bool, Option(help="Overwrite existing files")] = False
) -> None:
    cfg = Config(config)

    downloads = set(
        entry for entry in cfg.get_downloads()
        if not entry[1].exists() or force
    )
    symlinks = set(
        entry for entry in cfg.get_symlinks()
        if not entry[1].exists() or force
    )
    progress["total"] = len(symlinks) + len(downloads)

    for source, target in symlinks:
        if target.exists():
            delete(target)
        target.parents[0].mkdir(parents=True, exist_ok=True)
        os.symlink(source, target)
        log_progress(f"Symlink created: {target}")

    asyncio.run(async_download_all(downloads))


@app.command()
def clean(
    config: config_annotation = "./dottyper.yaml"
) -> None:
    cfg = Config(config)

    symlinks = cfg.get_symlinks()
    downloads = cfg.get_downloads()
    progress["total"] = len(symlinks) + len(downloads)

    for _, destination in symlinks.union(downloads):
        delete(destination)
        log_progress(f"File deleted: {destination}")


if __name__ == "__main__":
    app()
