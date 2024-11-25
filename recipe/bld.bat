setlocal EnableExtensions EnableDelayedExpansion
@echo on

%PYTHON% -m build --outdir . --no-isolation --wheel python/
for %%f in (*.whl) do (%PYTHON% -m pip install %%f --no-deps -vv)
