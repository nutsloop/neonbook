from __future__ import annotations

import os
import sys
from pathlib import Path

# Add themes to path for local development
theme_root = Path(__file__).parent.parent / "themes"
theme_map = {
    "neon-synth": ("sphinx_neon_synth_theme", theme_root / "sphinx-neon-synth-theme"),
    "neon-wave": ("sphinx_neon_wave_theme", theme_root / "sphinx-neon-wave-theme"),
}
theme_paths = [path for _, path in theme_map.values()]
for path in theme_paths:
    sys.path.insert(0, str(path))

# project details
project = "neonsignal"
author = "Simone Del Popolo"
release = "0.1.0"
book_title = "NeonSignal"
book_description = "Guides and references for building and operating NeonSignal."
book_homepage = "https://neonsignal.nutsloop.com"
book_github = "https://github.com/nutsloop/neonsignal"

# extensions
extensions = [
    "myst_parser",
    "sphinx_copybutton",
    "sphinx_design",
]

# Theme selection via env var (NEONBOOK_THEME=neon-synth|neon-wave)
theme_key = os.environ.get("NEONBOOK_THEME", "neon-synth").strip().lower()
theme_entry = theme_map.get(theme_key)
if theme_entry is None:
    for _, (theme_name, theme_path) in theme_map.items():
        if theme_key == theme_name:
            theme_entry = (theme_name, theme_path)
            break
if theme_entry is None:
    theme_entry = theme_map["neon-synth"]

html_theme, _selected_theme_path = theme_entry
html_theme_path = [str(path) for path in theme_paths]

def _env_flag(name: str, default: str = "on") -> bool:
    value = os.environ.get(name, default).strip().lower()
    return value not in {"0", "off", "false", "no"}

vhs_enabled = _env_flag("NEONBOOK_VHS", "on")
perf_log_enabled = _env_flag("NEONBOOK_PERF_LOG", "off")
perf_sound_enabled = _env_flag("NEONBOOK_PERF_SOUND", "off")
perf_notify_enabled = _env_flag("NEONBOOK_PERF_NOTIFY", "off")
html_context = {
    "neonbook_vhs": "on" if vhs_enabled else "off",
    "neonbook_perf_log": "on" if perf_log_enabled else "off",
    "neonbook_perf_sound": "on" if perf_sound_enabled else "off",
    "neonbook_perf_notify": "on" if perf_notify_enabled else "off",
    "neonbook_title": book_title,
    "neonbook_description": book_description,
    "neonbook_homepage": book_homepage,
    "neonbook_github": book_github,
}

html_theme_options = {
  "light_logo": "logo-light.svg",
  "dark_logo": "logo-dark.svg",
  "sidebar_hide_name": False,
  "navigation_with_keys": True,
  "default_theme": "system",
  "show_toc_level": 2,
}

templates_path = ["_templates"]
html_static_path = ["_static"]
html_extra_path = ["_static/favicon.svg"]
html_sidebars = {
    "**": ["globaltoc.html", "relations.html", "searchbox.html"],
}

source_suffix = {
    ".rst": "restructuredtext",
    ".md": "markdown",
}

myst_enable_extensions = [
    "colon_fence",
    "deflist",
    "tasklist",
]
