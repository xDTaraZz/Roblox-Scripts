"""Executor-compat gate for shipped scripts: old compilers, silent loadstring, loader/guard GameId drift."""
import json
import os
import re
import shutil
import subprocess
import sys
import unittest

sys.dont_write_bytecode = True

ROOT = os.getcwd()
MAP_DIR = os.path.join(ROOT, "All Map")
OLD_MAP_DIR = os.path.join(MAP_DIR, "old")
RAW_LOADSTRING = re.compile(r"loadstring\s*\((?:[^()]|\([^()]*\))*\)\s*\(")
GUARD = re.compile(r"game\.GameId\s*~=\s*(\d+)")
LOADER_ENTRY = re.compile(r"\[(\d+)\]\s*=\s*\"([^\"]+)\"")


def AstKinds(path):
    """Node kinds luau-ast reports for one file (FloorDiv, AstExprInterpString, ...)."""
    binary = shutil.which("luau-ast")
    if not binary:
        return set()
    run = subprocess.run([binary, path], capture_output=True, text=True, encoding="utf-8", errors="replace")
    return set(re.findall(r'"(FloorDiv|AstExprInterpString)"', run.stdout))


def StripStrings(source):
    return re.sub(r"\[(=*)\[.*?\]\1\]|\"(?:\\.|[^\"\\\n])*\"|'(?:\\.|[^'\\\n])*'|--[^\n]*", "", source, flags=re.S)


def CollectShippedScripts():
    shipped = []
    for folder in (MAP_DIR, OLD_MAP_DIR):
        if os.path.isdir(folder):
            shipped += [os.path.join(folder, name) for name in sorted(os.listdir(folder)) if name.endswith(".lua")]
    shipped += [os.path.join(ROOT, name) for name in ("loader.lua", "ui.lua") if os.path.isfile(os.path.join(ROOT, name))]
    return shipped


def CheckScriptSyntax(path):
    rel = os.path.relpath(path, ROOT)
    with open(path, encoding="utf-8") as handle:
        source = handle.read()
    failed = False
    for kind in sorted(AstKinds(path)):
        print(f"::error file={rel}::{kind} needs a newer Luau than many executors bundle")
        failed = True
    if RAW_LOADSTRING.search(StripStrings(source)):
        print(f"::error file={rel}::loadstring(...)() dies silently when loadstring returns nil; check the result")
        failed = True
    return failed


def ResolveGameScript(name):
    primary = os.path.join(MAP_DIR, name + ".lua")
    if os.path.isfile(primary):
        return primary
    legacy = os.path.join(OLD_MAP_DIR, name + ".lua")
    if os.path.isfile(legacy):
        return legacy
    return None


def CheckGameEntry(game_id, name):
    path = ResolveGameScript(name)
    if not path:
        print(f"::error file=loader.lua::{name} ({game_id}) has no All Map or All Map/old file")
        return True
    rel = os.path.relpath(path, ROOT)
    with open(path, encoding="utf-8") as handle:
        guard = GUARD.search(handle.read())
    if not guard or int(guard.group(1)) != game_id:
        print(f"::error file={rel}::guard GameId {guard and guard.group(1)} != loader {game_id}")
        return True
    return False


def main():
    shipped = CollectShippedScripts()
    failed = any(CheckScriptSyntax(path) for path in shipped)
    with open(os.path.join(ROOT, "loader.lua"), encoding="utf-8") as handle:
        games = {int(game_id): name for game_id, name in LOADER_ENTRY.findall(handle.read())}
    for game_id, name in sorted(games.items(), key=lambda pair: pair[1]):
        if CheckGameEntry(game_id, name):
            failed = True
    print(json.dumps({"files": len(shipped), "games": len(games), "ok": not failed}))
    return 1 if failed else 0


class CompatCheckSuite(unittest.TestCase):
    def TestCompatGate(self):
        self.assertEqual(main(), 0)
    test_compat_gate = TestCompatGate


if __name__ == "__main__":
    sys.exit(main())