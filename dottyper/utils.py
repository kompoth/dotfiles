from pathlib import Path
import os


def resolve_path(path):
    for var, value in os.environ.items():
        path = path.replace(f"${var}", value)
    return Path(path).resolve()


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
