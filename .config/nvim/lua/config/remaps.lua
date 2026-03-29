vim.g.mapleader = " "

-- Go to the build directory and run ninja
--
local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

-- This attempts to run cmake in the gitroot/build directory
vim.keymap.set('n', '<F5>',
  function()
    -- The path of .git
    local dot_git_path = vim.fn.finddir(".git", ".;")
    if (dot_git_path == nil or dot_git_path == '') then
      print("Not in a git repository!")
      return
    end

    -- The build path
    local cmake_build_dir = vim.fn.fnamemodify(dot_git_path, ":h") .. "/build"
    if not (vim.fn.isdirectory(cmake_build_dir)) then
      print("Not in a cmake repository!")
      return
    end

    vim.system({ 'ninja' }, { cwd = cmake_build_dir }, function(obj)
      if obj.code == 0 then
        -- obj.stdout is the command's output (string if text=true, else list of bytes)
        vim.schedule(function()
          vim.notify(obj.stdout, vim.log.levels.INFO)
        end)
      else
        vim.schedule(function()
          vim.notify("Error: " .. obj.stderr, vim.log.levels.ERROR)
        end)
      end
    end)

    vim.cmd("below split")
    vim.cmd.terminal()
    vim.api.nvim_chan_send(vim.bo.channel, "cd " .. cmake_build_dir .. "\r")
    vim.api.nvim_chan_send(vim.bo.channel, "ninja\r")
    -- Go to insert module (so we can do "exit" or something similar)
    vim.api.nvim_feedkeys("a", "t", false)
  end
)


