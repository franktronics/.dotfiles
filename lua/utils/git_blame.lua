local M = {}

local function git_root()
  local root = vim.fn.systemlist { 'git', 'rev-parse', '--show-toplevel' }[1]
  if vim.v.shell_error ~= 0 or not root or root == '' then return nil end
  return root
end

function M.open()
  local root = git_root()
  if not root then
    vim.notify('Not inside a Git repository', vim.log.levels.WARN)
    return
  end

  local file = vim.api.nvim_buf_get_name(0)
  local relative_file = vim.fn.fnamemodify(file, ':p'):sub(#root + 2)
  local line = vim.fn.line '.'
  local blame = vim.fn.systemlist({ 'git', '-C', root, 'blame', '--line-porcelain', '-L', line .. ',' .. line, '--', relative_file })
  if vim.v.shell_error ~= 0 or #blame == 0 then
    vim.notify('No Git blame available for this line', vim.log.levels.WARN)
    return
  end

  local commit = blame[1]:match '^(%S+)'
  if not commit or commit:match '^0+$' then
    vim.notify('This line is not committed yet', vim.log.levels.INFO)
    return
  end

  local author = ''
  local author_time = ''
  local summary = ''
  for _, entry in ipairs(blame) do
    author = entry:match('^author (.+)') or author
    author_time = entry:match('^author%-time (%d+)') or author_time
    summary = entry:match('^summary (.+)') or summary
  end

  local date = author_time ~= '' and os.date('%Y-%m-%d %H:%M:%S', tonumber(author_time)) or 'unknown date'
  local show = vim.fn.systemlist({ 'git', '-C', root, 'show', '--stat', '--patch', '--format=fuller', '--decorate', commit, '--', relative_file })
  local lines = {
    'Git Blame',
    '',
    'File: ' .. relative_file,
    'Line: ' .. line,
    'Commit: ' .. commit,
    'Author: ' .. author,
    'Date: ' .. date,
    'Summary: ' .. summary,
    '',
    string.rep('-', 80),
    '',
  }

  vim.list_extend(lines, show)

  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].bufhidden = 'wipe'
  vim.bo[buf].filetype = 'git'
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].modifiable = false

  local width = math.min(math.floor(vim.o.columns * 0.85), 120)
  local height = math.min(math.floor(vim.o.lines * 0.8), 40)
  local win = vim.api.nvim_open_win(buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    border = 'double',
    title = ' Git Blame ',
    title_pos = 'center',
    style = 'minimal',
  })

  vim.wo[win].wrap = false
  vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = buf, nowait = true, desc = 'Close blame window' })
  vim.keymap.set('n', '<esc>', '<cmd>close<cr>', { buffer = buf, nowait = true, desc = 'Close blame window' })
end

return M
