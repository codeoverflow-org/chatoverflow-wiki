#!/usr/bin/env bash
# fixes all links in the repo by stripping of /docs

find . -type f -name "*.md" -exec sed -i 's:\[\([^][\n]*\)\](/docs/\([^ \n()]\+\)):[\1](/\2):g' {} +
find . -type f -name "*.md" -exec sed -i 's:<img\([^>\n]* src *= *\)"/docs/\([^ >\n]\+\)"\([^>\n]*\)>:<img\1"/\2"\3>:g' {} +