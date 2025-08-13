-- Keymaps for vscode-neovim

if not vim.g.vscode then
  return {}
end

local map = vim.keymap.set

local function action(action, opts)
  return function()
    require("vscode").action(action, opts)
  end
end

-- Override the Snacks terminal action
function _G.Snacks.terminal()
  require("vscode").action("workbench.action.terminal.toggleTerminal")
end

-- Don't close neovim
vim.keymap.del("n", "<leader>qq")

-- Files
map("n", "<leader>e", action("workbench.view.explorer"), { desc = "File Explorer" })
map("n", "<leader>fn", action("workbench.action.files.newUntitledFile"), { desc = "New File" })
map("n", "<leader>ff", action("workbench.action.quickOpen"), { desc = "Find Files" })
map("n", "<leader>fr", action("workbench.action.openRecent"), { desc = "Recent Files" })
map("n", "<leader>fb", action("workbench.action.quickOpenPreviousRecentlyUsedEditorInGroup"), { desc = "Find Buffer" })

-- Search and navigation
map("n", "<leader><space>", action("workbench.action.quickOpen"), { desc = "Find Files" })
map("n", "<leader>/", action("workbench.action.findInFiles"), { desc = "Search in Files" })
map("n", "<leader>ss", action("workbench.action.gotoSymbol"), { desc = "Go to Symbol" })
map("n", "<leader>sS", action("workbench.action.showAllSymbols"), { desc = "Go to Symbol (Workspace)" })
map("n", "<leader>sg", action("workbench.action.findInFiles"), { desc = "Grep" })
map("n", "<leader>sw", function()
  local query = vim.fn.expand("<cword>")
  action("workbench.action.findInFiles", { args = { query = query } })()
end, { desc = "Search Current Word" })

-- Buffer/Tab operations
map("n", "<S-h>", action("workbench.action.previousEditor"), { desc = "Prev Buffer" })
map("n", "<S-l>", action("workbench.action.nextEditor"), { desc = "Next Buffer" })
map("n", "[b", action("workbench.action.previousEditor"), { desc = "Prev Buffer" })
map("n", "]b", action("workbench.action.nextEditor"), { desc = "Next Buffer" })
map("n", "<leader>bd", action("workbench.action.closeActiveEditor"), { desc = "Delete Buffer" })
map("n", "<leader>bD", action("workbench.action.closeActiveEditor"), { desc = "Delete Buffer" })
map("n", "<leader>bo", action("workbench.action.closeOtherEditors"), { desc = "Delete Other Buffers" })

-- Code actions and LSP
map("n", "<leader>ca", action("editor.action.quickFix"), { desc = "Code Action" })
map("n", "<leader>cr", action("editor.action.rename"), { desc = "Rename" })
map("n", "<leader>cf", action("editor.action.formatDocument"), { desc = "Format Document" })
---- These are set by default in vscode-neovim
-- map("n", "gd", vscode_action('editor.action.revealDefinition'), { desc = "Go to Definition" })
-- map("n", "gD", vscode_action('editor.action.revealDeclaration'), { desc = "Go to Declaration" })
map("n", "gr", action("editor.action.goToReferences"), { desc = "Go to References" })
map("n", "gi", action("editor.action.goToImplementation"), { desc = "Go to Implementation" })
map("n", "gt", action("editor.action.goToTypeDefinition"), { desc = "Go to Type Definition" })

-- Folding
map("n", "za", action("editor.toggleFold"), { desc = "Toggle Fold" })
map("n", "zA", action("editor.toggleFoldRecursively"), { desc = "Toggle Fold Recursively" })
map("n", "zc", action("editor.fold"), { desc = "Close Fold" })
map("n", "zC", action("editor.foldRecursively"), { desc = "Close Fold Recursively" })
map("n", "zo", action("editor.unfold"), { desc = "Open Fold" })
map("n", "zO", action("editor.unfoldRecursively"), { desc = "Open Fold Recursively" })
map("n", "zM", action("editor.foldAll"), { desc = "Close All Folds" })
map("n", "zR", action("editor.unfoldAll"), { desc = "Open All Folds" })

-- Git
-- Hunk navigation
map("n", "]h", action("workbench.action.editor.nextChange"), { desc = "Next Hunk" })
map("n", "[h", action("workbench.action.editor.previousChange"), { desc = "Prev Hunk" })

-- Hunk operations
map({ "n", "v" }, "<leader>ghs", action("git.stageSelectedRanges"), { desc = "Stage Hunk" })
-- NOTE: Unstage does not work outside of the diff viewer - https://github.com/microsoft/vscode/issues/96850
map({ "n", "v" }, "<leader>ghu", action("git.unstageSelectedRanges"), { desc = "Unstage Hunk" })
map({ "n", "v" }, "<leader>ghr", action("git.revertSelectedRanges"), { desc = "Reset Hunk" })
map("n", "<leader>ghS", action("git.stageFile"), { desc = "Stage Buffer" })
map("n", "<leader>ghU", action("git.unstageFile"), { desc = "Stage Buffer" })
map(
  "n",
  "<leader>ghR",
  action("git.revertSelectedRanges", {
    range = { 0, vim.api.nvim_buf_line_count(0) },
  }),
  { desc = "Reset Buffer" }
)
map("n", "<leader>ghp", action("editor.action.peekChanges"), { desc = "Preview Hunk Inline" })
map("n", "<leader>ghb", action("gitlens.toggleLineBlame"), { desc = "Blame Line" })
map("n", "<leader>ghB", action("gitlens.toggleFileBlame"), { desc = "Blame Buffer" })
map("n", "<leader>ghd", action("git.openChange"), { desc = "Diff This" })
map("n", "<leader>ghD", action("workbench.scm.focus"), { desc = "Diff This ~" })
