import yaml
from typing import Optional
from urllib.parse import urlparse
from pathlib import Path
import os

ENV_VARS = os.environ.items()


class Config:
    _CONFIG: Optional[dict] = None

    def __init__(self, config_path: str):
        with open(config_path, "r") as fd:
            Config._CONFIG = yaml.safe_load(fd)

    @staticmethod
    def __handle_path(path: str) -> Path:
        for var, value in ENV_VARS:
            path = path.replace(f"${var}", value)
        return Path(path).resolve()

    @staticmethod
    def get_symlinks():
        symlinks = set()
        for group in Config._CONFIG.get("symlinks", []):
            destination = Config.__handle_path(group["destination"])
            location = Config.__handle_path(group["location"])
            for source_file in group["files"]:
                source = location / source_file
                target = destination / source.name
                symlinks.add((source, target))
        return symlinks

    @staticmethod
    def get_downloads():
        downloads = set()
        for group in Config._CONFIG.get("downloads", []):
            destination = Config.__handle_path(group["destination"])
            for url in group["urls"]:
                file_name = urlparse(url).path.split("/")[-1]
                target = destination / file_name
                downloads.add((url, target))
        return downloads
