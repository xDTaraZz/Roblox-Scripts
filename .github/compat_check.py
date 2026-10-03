"""Executor-compat gate for shipped scripts: old compilers, silent loadstring, loader/guard GameId drift."""
import json
import os
import re
import subprocess
import sys

ROOT = os.getcwd()
MAP_DIR = os.path.join(ROOT, "All Map")
RAW_LOADSTRING = re.compile(r"loadstring\s*\((?:[^()]|\([^()]*\))*\)\s*\(")
GUARD = re.compile(r"game\.GameId\s*~=\s*(\d+)")
LOADER_ENTRY = re.compile(r"\[(\d+)\]\s*=\s*\"([^\"]+)\"")


def ast_kinds(path):
    """Node kinds luau-ast reports for one file (FloorDiv, AstExprInterpString, ...)."""
    run = subprocess.run(["luau-ast", path], capture_output=True, text=True, encoding="utf-8", errors="replace")
    return set(re.findall(r'"(FloorDiv|AstExprInterpString)"', run.stdout))


def strip_strings(source):
    return re.sub(r"\[(=*)\[.*?\]\1\]|\"(?:\\.|[^\"\\\n])*\"|'(?:\\.|[^'\\\n])*'|--[^\n]*", "", source, flags=re.S)


def main():
    failed = False
    shipped = [os.path.join(MAP_DIR, name) for name in sorted(os.listdir(MAP_DIR)) if name.endswith(".lua")]
    shipped += [os.path.join(ROOT, name) for name in ("loader.lua", "ui.lua") if os.path.isfile(os.path.join(ROOT, name))]
    for path in shipped:
        rel = os.path.relpath(path, ROOT)
        with open(path, encoding="utf-8") as handle:
            source = handle.read()
        for kind in sorted(ast_kinds(path)):
            print(f"::error file={rel}::{kind} needs a newer Luau than many executors bundle")
            failed = True
        if RAW_LOADSTRING.search(strip_strings(source)):
            print(f"::error file={rel}::loadstring(...)() dies silently when loadstring returns nil; check the result")
            failed = True
    with open(os.path.join(ROOT, "loader.lua"), encoding="utf-8") as handle:
        games = {int(game_id): name for game_id, name in LOADER_ENTRY.findall(handle.read())}
    for game_id, name in sorted(games.items(), key=lambda pair: pair[1]):
        path = os.path.join(MAP_DIR, name + ".lua")
        if not os.path.isfile(path):
            print(f"::error file=loader.lua::{name} ({game_id}) has no All Map file")
            failed = True
            continue
        with open(path, encoding="utf-8") as handle:
            guard = GUARD.search(handle.read())
        if not guard or int(guard.group(1)) != game_id:
            print(f"::error file=All Map/{name}.lua::guard GameId {guard and guard.group(1)} != loader {game_id}")
            failed = True
    print(json.dumps({"files": len(shipped), "games": len(games), "ok": not failed}))
    return 1 if failed else 0


if __name__ == "__main__":
    sys.exit(main())