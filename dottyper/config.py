import yaml
from typing import Optional
from urllib.parse import urlparse

from .utils import resolve_path


class Config:
    _CONFIG: Optional[dict] = None

    def __init__(self, config_path: str):
        with open(config_path, "r") as fd:
            Config._CONFIG = yaml.safe_load(fd)

    @staticmethod
    def get_symlinks():
        symlinks = []
        for directory in Config._CONFIG.get("symlinks", []):
            target_dir = resolve_path(directory["destination"])
            for source_file in directory["files"]:
                source = resolve_path(source_file)
                target = target_dir / source.name
                symlinks.append((source, target))
        return symlinks

    @staticmethod
    def get_downloads():
        downloads = []
        for directory in Config._CONFIG.get("downloads", []):
            target_dir = resolve_path(directory["destination"])
            for url in directory["urls"]:
                file_name = urlparse(url).path.split("/")[-1]
                target = target_dir / file_name
                downloads.append((url, target))
        return downloads

    @staticmethod
    def get_repos():
        repos = []
        for directory in Config._CONFIG.get("repos", []):
            target_dir = resolve_path(directory["destination"])
            for gh_path in directory["github"]:
                repo_url = "https://github.com/" + gh_path
                repo_name = gh_path.split("/")[-1]
                target = target_dir / repo_name
                repos.append((repo_url, target))
        return repos
