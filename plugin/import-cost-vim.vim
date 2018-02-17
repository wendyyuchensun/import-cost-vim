function! BufContent()
  return join(getline(1, "$"), "\n")
endfunction

function! GetImportCost()
  let IMPORT_COST_PATH = $HOME . "/.vim/bundle/import-cost-vim"
  let filePath = expand("%:p")
  let fileType = expand("%:e")
  let fileContents = substitute(BufContent(), "\"", "\'", "")

  let cmd = "npm run start --prefix " . IMPORT_COST_PATH . " " . filePath . " " . fileType
  let data = system(cmd)

  return data
endfunction

function! TargetLines(line)
  if a:line =~ 'line'
    return 1
  elseif a:line =~ 'size'
    return 1
  elseif a:line =~ 'gzip'
    return 1
  else
    return 0
  endif
endfunction

function! ProcessCostData(data)
  let raw = split(substitute(a:data, ",", "", ""), "\n")[3:]
  let useful = filter(raw, 'TargetLines(v:val)')

  let tmp = {}
  let clean = []

  for item in useful
    if item =~ 'line'
      let tmp.line = str2nr(substitute(split(item, " ")[1], ",", "", ""))
    elseif item =~ 'size'
      let tmp.size = str2nr(substitute(split(item, " ")[1], ",", "", ""))
    else
      let tmp.gzip = str2nr(substitute(split(item, " ")[1], ",", "", ""))
      let clean = clean + [tmp]
      let tmp = {}
    endif
  endfor

  return clean
endfunction

function! NrHelper(num)
  return string(a:num / 1024)
endfunction

function! ShowImportCost()
  let data = ProcessCostData(GetImportCost())

  for item in data
    let cmd = ":normal! " . item.line . "ggA // " . NrHelper(item.size) . "K  (gzipped: " . NrHelper(item.gzip) .  "K)\<esc>"
    execute cmd    
  endfor

  return ""
endfunction

autocmd BufRead *.js :call ShowImportCost()
