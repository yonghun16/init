--------------------------------------------------------------------------------
-- Plugins
--------------------------------------------------------------------------------
lvim.plugins = {
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
    "preservim/tagbar", -- https://github.com/universal-ctags/ctags
    "easymotion/vim-easymotion",
    "farmergreg/vim-lastplace",
    "mg979/vim-visual-multi",
    "Mofiqul/vscode.nvim",
    "mattn/emmet-vim",
    "NvChad/nvim-colorizer.lua",
    "digitaltoad/vim-pug",
    "prettier/vim-prettier",
    "sbdchd/neoformat"
  },
}


--------------------------------------------------------------------------------
-- Plugins Setting
--------------------------------------------------------------------------------
-- tagbar
vim.cmd([[ let g:tagbar_position = 'topleft vertical' ]])
vim.cmd([[ let g:tagbar_width = '30' ]])

-- visual-multi
vim.cmd([[ let g:VM_maps = {} ]])
vim.cmd([[ let g:VM_maps["Find Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Find Subword Under"]   = '<C-/>' ]])
vim.cmd([[ let g:VM_maps["Add Cursor At Pos"]   = '<C-Right>' ]])

-- emmet-vim
vim.cmd([[ let g:user_emmet_leader_key=',' ]])

-- nvim-colorizer.lua
require 'colorizer'.setup {
  user_default_options = {
    css_fn = false,
    css = true,
    scss = true
  }
}


--------------------------------------------------------------------------------
-- Function
--------------------------------------------------------------------------------
-- Compile
function Compile()
  local filetype = vim.bo.filetype
  if filetype == "c" then
    vim.cmd('w')
    vim.cmd('! gcc -o ~/bin/%< %<.c')
    vim.cmd('! ~/bin/%<')
  elseif filetype == "cpp" then
    vim.cmd('w')
    vim.cmd('! g++ -o ~/bin/%< %<.cpp')
    vim.cmd('! ~/bin/%<')
  elseif filetype == "java" then
    vim.cmd('w')
    vim.cmd('! javac -encoding utf-8 -d ~/bin %<.java')
    vim.cmd('! java -cp ~/bin %<')
  elseif filetype == "python" then
    vim.cmd('w')
    vim.cmd('! python3 %<.py')
  elseif filetype == "javascript" then
    vim.cmd('w')
    vim.cmd('! node %<.js')
  else
    vim.cmd(':echo "This file is not source"')
  end
end

-- Auto Wrap
function Toggle_wrap()
  vim.cmd('set wrap!')
end

--------------------------------------------------------------------------------
-- Autocmd Rules
--------------------------------------------------------------------------------
vim.cmd 'au BufEnter * call v:lua.BufEnter_f()'
vim.cmd 'au BufLeave * call v:lua.BufLeave_f()'
-- vim.cmd 'au BufWinEnter * silent! loadview'
-- vim.cmd 'au BufWinLeave * mkview'

function BufEnter_f()
  if (vim.bo.buftype == "terminal"
      or vim.bo.buftype == "nofile"
      or vim.o.filetype == "tagbar"
      or vim.o.filetype == "NvimTree"
      or vim.o.filetype == "dashboard"
      ) then
    vim.cmd('set norelativenumber')
  else
    vim.cmd('set relativenumber')
  end
end

function BufLeave_f()
  vim.cmd('set norelativenumber')
end

--------------------------------------------------------------------------------
-- Language Setting
--------------------------------------------------------------------------------
vim.cmd 'autocmd Filetype pug setlocal ts=4 sw=4 expandtab'


--------------------------------------------------------------------------------
-- Basic options
--------------------------------------------------------------------------------
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 3

lvim.colorscheme = "vscode"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false
lvim.builtin.treesitter.auto_install = true
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
  pattern = "*.lua",
  timeout = 1000,
}

vim.cmd('set viewdir=~/.vim/view')


--------------------------------------------------------------------------------
-- Mappings
-- ~ .local/share/lunarvim/lvim/lua/lvim/core/which_key  ->  기본 which키 셋팅
--------------------------------------------------------------------------------
-- leader 키 설정
lvim.builtin.which_key.mappings["e"] = {}
lvim.leader = ","

-- ESC 키를 편하게 <Ctrl+f>로 변경
lvim.keys.normal_mode["<C-f>"] = "<ESC>"
lvim.keys.term_mode["<C-f>"] = "<C-\\><C-n>"
lvim.keys.term_mode["<ESC>"] = "<C-\\><C-n>"
lvim.keys.insert_mode["<C-f>"] = "<ESC>"
lvim.keys.visual_mode["<C-f>"] = "<ESC>"
lvim.keys.command_mode["<C-f>"] = "<ESC>"

-- 편집모드에서 터미널 단축키 사용 및 기타
lvim.keys.term_mode["<C-k>"] = false
lvim.keys.term_mode["<C-j>"] = false
lvim.keys.term_mode["<C-l>"] = "<RIGHT>"
lvim.keys.term_mode["<C-h>"] = false
lvim.keys.insert_mode["<C-l>"] = "<RIGHT>"
lvim.keys.insert_mode["<C-b>"] = "<LEFT>"
lvim.keys.insert_mode["<C-a>"] = "<ESC>^i"
lvim.keys.insert_mode["<C-e>"] = "<ESC>$a"
lvim.keys.insert_mode["<C-d>"] = "<DEL>"
lvim.keys.insert_mode["<C-k>"] = "<ESC><RIGHT>C"
lvim.keys.insert_mode["<C-u>"] = "<ESC><RIGHT>d^i"
lvim.keys.insert_mode["<C-ENTER>"] = "<ESC>o"
lvim.keys.insert_mode["<A-f>"] = "<ESC><RIGHT>wi"
lvim.keys.insert_mode["<A-b>"] = "<ESC>bi"

-- 영역지정 된 행을 위아래로 이동
lvim.keys.normal_mode["<A-k>"] = false
lvim.keys.normal_mode["<A-j>"] = false
lvim.keys.visual_mode["<S-j>"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["<S-k>"] = ":m '<-2<CR>gv=gv"

-- 빠른 커서 이동,  페이지 이동
lvim.keys.normal_mode["<C-k>"] = "3k"
lvim.keys.normal_mode["<C-j>"] = "3j"
lvim.keys.normal_mode["<C-l>"] = "$"
lvim.keys.normal_mode["<C-h>"] = "^"
lvim.keys.normal_mode["<C-n>"] = "<C-e><down><Up><C-e><down><up><C-e>"
lvim.keys.normal_mode["<C-p>"] = "<C-y><up><down><C-y><up><down><C-y>"
lvim.keys.visual_mode["<C-k>"] = "3k"
lvim.keys.visual_mode["<C-j>"] = "3j"
lvim.keys.visual_mode["<C-l>"] = "$"
lvim.keys.visual_mode["<C-h>"] = "^"
lvim.keys.visual_mode["<C-n>"] = "<C-e><down><Up><C-e><down><up><C-e>"
lvim.keys.visual_mode["<C-p>"] = "<C-y><up><down><C-y><up><down><C-y>"

-- 분할창 크기조절
lvim.keys.normal_mode["<C-UP>"] = false
lvim.keys.normal_mode["<C-DOWN>"] = false
lvim.keys.normal_mode["<C-RIGHT>"] = false
lvim.keys.normal_mode["<C-LEFT>"] = false
lvim.keys.normal_mode["<A-UP>"] = "<C-W>2-"
lvim.keys.normal_mode["<A-DOWN>"] = "<C-W>2+"
lvim.keys.normal_mode["<A-RIGHT>"] = "<C-W>2>"
lvim.keys.normal_mode["<A-LEFT>"] = "<C-W>2<"

-- Buffer
lvim.keys.normal_mode["<tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<s-tab>"] = ":BufferLineCyclePrev<CR>"

-- 영역지정 된 행을 위아래로 이동,  들여쓰기/ 내어쓰기
-- lvim.keys.visual_mode["<A-j>"] = ":m '>+1<CR>gv=gv"
-- lvim.keys.visual_mode["<A-k>"] = ":m '<-2<CR>gv=gv"
lvim.keys.visual_mode[">>"] = ">gv"
lvim.keys.visual_mode["<<"] = "<gv"

-- prettier
-- npm install -g prettier
lvim.keys.normal_mode["<A-f>"] = "<Plug>(Prettier)"
lvim.builtin.which_key.mappings["p"] = { '<Plug>(Prettier)', "Prettier" }

-- 사이드바
lvim.builtin.which_key.mappings["k"] = { "<cmd>Telescope buffers previewer=false<cr>", "Buffer list" }
lvim.builtin.which_key.mappings["h"] = { "<cmd>:TagbarToggle<CR>", "Tagbar" }
lvim.builtin.which_key.mappings["l"] = { "<cmd>NvimTreeToggle<CR>", "File Explorer" }
lvim.builtin.which_key.mappings["j"] = {
  "<cmd>:ToggleTerm size=13 direction=horizontal <CR><C-\\><C-n>:call v:lua.BufEnter_f()<CR>", "Terminal bottom" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>:ToggleTerm direction=float<CR>", "Terminal" }

-- Clean search (highlight)
lvim.builtin.which_key.mappings["<space>"] = { '<cmd>let @/=""<CR>', "No Highlight" }

-- Compile
lvim.builtin.which_key.mappings["a"] = { '<cmd>lua Compile()<CR>', "Compile" }

-- Auto wrap
lvim.builtin.which_key.mappings["z"] = { '<cmd>lua Toggle_wrap()<CR>', "Wrap" }

-- 파일비교
lvim.builtin.which_key.mappings["d"] = { ':vert diffsplit ', "diffsplit" }

-- 레지스터 보기
lvim.builtin.which_key.mappings["r"] = { '<cmd>:reg<cr>', "Register" }

-- Easymotion
lvim.builtin.which_key.mappings["f"] = { '<Plug>(easymotion-f)', "easymotion-f" }
lvim.builtin.which_key.mappings["F"] = { '<Plug>(easymotion-F)', "easymotion-F" }

-- 현재 경로를 작업경로로 설정
lvim.builtin.which_key.mappings[","] = { '<cmd>:lcd %:p:h<CR>:echo expand(\'%:p:h\')<CR>', "change workspace" }