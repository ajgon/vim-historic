if exists("g:localHistoryInstalled")
	finish
else
	let g:localHistoryInstalled = 1
endif

if !exists("g:localHistoryBackupRepoLocation")
	let g:localHistoryBackupRepoLocation = '~/.vim.backup'
endif

let s:installPath = expand('<sfile>:p:h')

function! s:backup(filepath)
	:let output = system("sh " . s:installPath . "/../bin/backup.sh " . g:localHistoryBackupRepoLocation . " " . a:filepath)
endfunction

function! s:listHistory(filepath)
	let currentPath = expand("%:p:h")
	exec "cd " . g:localHistoryBackupRepoLocation
	exec "!git --no-pager log --no-color --pretty=oneline ." . a:filepath
	exec "cd " . currentPath
endfunction

command! HistoricList :call s:listHistory(expand("%:p"))
command! HistoricBackup :call s:backup(expand("%:p"))

autocmd! BufWritePost * :HistoricBackup<cr>
