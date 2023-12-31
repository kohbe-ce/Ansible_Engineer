# Copyright 2015 Koichi Murase <myoga.murase@gmail.com>. All rights reserved.
# This script is a part of blesh (https://github.com/akinomyoga/ble.sh)
# provided under the BSD-3-Clause license.  Do not edit this file because this
# is not the original source code: Various pre-processing has been applied.
# Also, the code comments and blank lines are stripped off in the installation
# process.  Please find the corresponding source file(s) in the repository
# "akinomyoga/ble.sh".
#
# Source: /lib/test-complete.sh
ble-import lib/core-complete
ble-import lib/core-test
ble/test/start-section 'ble/complete' 7
(
  function _collect {
    local text=${args[1]} p0=0 i out=
    for ((i=0;i<${#ret[@]};i++)); do
      ((p=ret[i]))
      if ((i%2==0)); then
        out=$out${text:p0:p-p0}'['
      else
        out=$out${text:p0:p-p0}']'
      fi
      p0=$p
    done
    ((p0<${#text})) && out=$out${text:p0}
    ret=$out
  }
  ble/test 'args=(akf Makefile 0); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='M[ak]e[f]ile'
  ble/test 'args=(akf Makefile 1); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='Makefile'
  ble/test 'args=(Mkf Makefile 1); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='[M]a[k]e[f]ile'
  ble/test 'args=(Maf Makefile 1); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='[Ma]ke[f]ile'
  ble/test 'args=(Mak Makefile 1); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='[Mak]efile'
  ble/test 'args=(ake Makefile 0); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='M[ake]file'
  ble/test 'args=(afe Makefile 0); ble/complete/candidates/filter:hsubseq/match "${args[@]}"; _collect' ret='M[a]ke[f]il[e]'
)
ble/test/end-section
