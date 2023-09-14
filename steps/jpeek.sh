#!/bin/bash
# The MIT License (MIT)
#
# Copyright (c) 2021-2022 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
set -e

jobs=${TARGET}/temp/jpeek-jobs.txt
rm -rf "${jobs}"
mkdir -p "$(dirname "${jobs}")"

repos=$(find "${TARGET}/github" -depth 2 -type d -print)
total=$(echo $repos | wc -w | xargs)

declare -i repo=0
for r in ${repos}; do
    repo=repo+1
    echo "$(dirname "$0")/jpeek-repo.sh" "${r}" "${repo}" "${total}" >> "${jobs}"
done

cat "${jobs}" | xargs -I {} -P 0 "${SHELL}" -c "{}"
wait
echo "All repos passed through jPeek, ${total} repositories"