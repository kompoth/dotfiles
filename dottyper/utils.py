from pathlib import Path
import os


def resolve_path(path):
    for var, value in os.environ.items():
        path = path.replace(f"${var}", value)
    return Path(path).resolve()

