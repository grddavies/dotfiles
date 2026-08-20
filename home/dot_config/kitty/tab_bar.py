"""
Render kitty tab title
"""

import subprocess
from functools import lru_cache

VIM_ICON = "\ue62b"
NVIM_ICON = "\uf36f"


@lru_cache(maxsize=256)
def _worktree_leaf(wd):
    """Return 'parent/leaf' if wd is a linked git worktree, else None."""
    try:
        p = subprocess.run(
            ["git", "-C", wd, "rev-parse", "--git-dir", "--git-common-dir"],
            capture_output=True,
            text=True,
            timeout=0.3,
        )
    except Exception:
        return None
    if p.returncode != 0:
        return None
    lines = p.stdout.strip().splitlines()
    if len(lines) != 2:
        return None
    git_dir, common_dir = lines
    if git_dir == common_dir:
        return None  # main checkout, not a linked worktree
    parts = wd.rstrip("/").split("/")
    return "/".join(parts[-2:]) if len(parts) >= 2 else parts[-1]


def draw_title(data):
    title = data["title"]
    wd = data["tab"].active_wd
    leaf = wd.rstrip("/").split("/")[-1]
    if title == "vim":
        return f"{VIM_ICON} {_worktree_leaf(wd) or leaf}"
    if title == "nvim":
        return f"{NVIM_ICON} {_worktree_leaf(wd) or leaf}"
    return title
