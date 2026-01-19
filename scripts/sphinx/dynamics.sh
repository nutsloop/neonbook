#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../global_variables.sh"
source "$NEONBOOK_LOGGING_LIB_SCRIPT"

print_header "NeonSignal Sphinx Dynamics"

benchmarks_ready=false
if [[ -d "$NEONBOOK_SPHINX_BENCHMARK_SOURCE_DIR" ]]; then
  benchmarks_ready=true
  mkdir -p "$NEONBOOK_SPHINX_BENCHMARK_TARGET_DIR"
  print_step "Copying benchmark reports"
  if ! compgen -G "${NEONBOOK_SPHINX_BENCHMARK_SOURCE_DIR}/*.md" > /dev/null; then
    print_warning "No benchmark markdown files found in ${NEONBOOK_SPHINX_BENCHMARK_SOURCE_DIR}"
  else
    cp -f "${NEONBOOK_SPHINX_BENCHMARK_SOURCE_DIR}/"*.md "$NEONBOOK_SPHINX_BENCHMARK_TARGET_DIR/"
    print_success "Copied benchmark reports to ${NEONBOOK_SPHINX_BENCHMARK_TARGET_DIR}"
  fi
else
  print_warning "Benchmark source directory not found: ${NEONBOOK_SPHINX_BENCHMARK_SOURCE_DIR}"
fi

print_step "Copying AI collaboration plans"
mkdir -p "$NEONBOOK_SPHINX_AI_TARGET_DIR"
if ! compgen -G "${NEONBOOK_AI_PLANS_DIR}/*.md" > /dev/null; then
  print_warning "No plan markdown files found in ${NEONBOOK_AI_PLANS_DIR}"
else
  python3 - "$NEONBOOK_AI_PLANS_DIR" "$NEONBOOK_SPHINX_AI_TARGET_DIR" <<'PY'
import re
import sys
from pathlib import Path

source = Path(sys.argv[1])
target = Path(sys.argv[2])

def title_from_name(name: str) -> str:
    cleaned = name.replace("_", " ").replace("-", " ").strip()
    return " ".join(word.capitalize() for word in cleaned.split())

def normalize_content(text: str, fallback_title: str) -> str:
    lines = text.splitlines()
    idx = 0
    while idx < len(lines) and not lines[idx].strip():
        idx += 1

    if idx < len(lines) and lines[idx].startswith("# "):
        heading = lines[idx].strip()
        body = "\n".join(lines[idx + 1 :])
    else:
        heading = f"# {fallback_title}"
        body = "\n".join(lines[idx:])

    if not re.search(r"(?m)^##\s", body) and re.search(r"(?m)^###\s", body):
        body = re.sub(r"(?m)^###\s", "## ", body)

    return heading + "\n\n" + body.strip() + "\n"

for path in sorted(source.glob("*.md")):
    if not path.is_file():
        continue
    dest = target / path.name
    content = path.read_text(encoding="utf-8")
    title = title_from_name(path.stem)
    dest.write_text(normalize_content(content, title), encoding="utf-8")
PY
  print_success "Copied plan reports to ${NEONBOOK_SPHINX_AI_TARGET_DIR}"
fi

if [[ "$benchmarks_ready" == true ]]; then
  print_step "Regenerating benchmark index"

  benchmark_toc_file="$NEONBOOK_SPHINX_BENCHMARK_TARGET_DIR/_toc.generated.md"

  declare -a full_reports=()
  declare -a quick_reports=()
  declare -a app_reports=()
  declare -a all_reports=()
  report=""

  while IFS= read -r -d '' file; do
    filename="$(basename "$file")"
    if [[ "$filename" == "_toc.generated.md" ]]; then
      continue
    fi
    if [[ "$filename" == full.*.md ]]; then
      full_reports+=("$filename")
    elif [[ "$filename" == quick.app.js.*.md ]]; then
      app_reports+=("$filename")
    elif [[ "$filename" == quick*.md ]]; then
      quick_reports+=("$filename")
    fi
  done < <(find "$NEONBOOK_SPHINX_BENCHMARK_TARGET_DIR" -maxdepth 1 -type f -name "*.md" -print0)

  IFS=$'\n' full_reports=($(sort <<<"${full_reports[*]}"))
  IFS=$'\n' quick_reports=($(sort <<<"${quick_reports[*]}"))
  IFS=$'\n' app_reports=($(sort <<<"${app_reports[*]}"))
  unset IFS

  all_reports=("${full_reports[@]}" "${quick_reports[@]}" "${app_reports[@]}")

  if [[ ${#all_reports[@]} -gt 0 ]]; then
    python3 - "$benchmark_toc_file" "${all_reports[@]}" <<'PY'
import sys

toc_path = sys.argv[1]
reports = sys.argv[2:]

block_lines = [
    "```{toctree}",
    ":maxdepth: 1",
    "",
]
block_lines.extend([f"{name[:-3]}" for name in reports])
block_lines.append("```")
block = "\n".join(block_lines) + "\n"

with open(toc_path, "w", encoding="utf-8") as handle:
    handle.write(block)
PY
  fi

  print_success "Generated ${benchmark_toc_file}"
else
  print_warning "Skipping benchmark index generation"
fi

print_step "Regenerating AI conversations index"

ai_toc_file="$NEONBOOK_SPHINX_AI_TARGET_DIR/_toc.generated.md"

declare -a plan_docs=()
while IFS= read -r -d '' file; do
  filename="$(basename "$file")"
  if [[ "$filename" != "index.md" && "$filename" != "_toc.generated.md" ]]; then
    plan_docs+=("$filename")
  fi
done < <(find "$NEONBOOK_SPHINX_AI_TARGET_DIR" -maxdepth 1 -type f -name "*.md" -print0)

IFS=$'\n' plan_docs=($(sort <<<"${plan_docs[*]}"))
unset IFS

if [[ ${#plan_docs[@]} -gt 0 ]]; then
  python3 - "$ai_toc_file" "${plan_docs[@]}" <<'PY'
import sys

toc_path = sys.argv[1]
docs = sys.argv[2:]

block_lines = [
    "```{toctree}",
    ":maxdepth: 1",
    "",
]
block_lines.extend([f"{name[:-3]}" for name in docs])
block_lines.append("```")
block = "\n".join(block_lines) + "\n"

with open(toc_path, "w", encoding="utf-8") as handle:
    handle.write(block)
PY
  print_success "Generated ${ai_toc_file}"
else
  print_warning "No plan docs found for AI conversations index"
fi
