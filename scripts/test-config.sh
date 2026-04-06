#!/bin/bash
# test-config.sh - Integration test for neovim config
set -uo pipefail

NVIM_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

PASS=0
FAIL=0

test_module() {
  echo -e "\e[1;34mTesting $1...\e[0m"
  if nvim --headless -u NORC --noplugin \
    -c "set runtimepath+=${NVIM_CONFIG_DIR}" \
    -c "lua $2" -c 'qall' 2>&1; then
    echo -e "\e[1;32mPASS: $1\e[0m"
    ((PASS++))
  else
    echo -e "\e[1;31mFAIL: $1\e[0m"
    ((FAIL++))
  fi
}

test_module_pcall() {
  echo -e "\e[1;34mTesting $1...\e[0m"
  if nvim --headless -u NORC --noplugin \
    -c "set runtimepath+=${NVIM_CONFIG_DIR}" \
    -c "lua if $2 then print('OK') end" -c 'qall' 2>&1 | grep -q 'OK'; then
    echo -e "\e[1;32mPASS: $1\e[0m"
    ((PASS++))
  else
    echo -e "\e[1;31mFAIL: $1\e[0m"
    ((FAIL++))
  fi
}

test_function_exists() {
  echo -e "\e[1;34mTesting $1...\e[0m"
  if nvim --headless -u NORC --noplugin \
    -c "set runtimepath+=${NVIM_CONFIG_DIR}" \
    -c "lua if type($2) == 'function' then print('OK') end" -c 'qall' 2>&1 | grep -q 'OK'; then
    echo -e "\e[1;32mPASS: $1\e[0m"
    ((PASS++))
  else
    echo -e "\e[1;31mFAIL: $1\e[0m"
    ((FAIL++))
  fi
}

test_table_exists() {
  echo -e "\e[1;34mTesting $1...\e[0m"
  if nvim --headless -u NORC --noplugin \
    -c "set runtimepath+=${NVIM_CONFIG_DIR}" \
    -c "lua if type($2) == 'table' then print('OK') end" -c 'qall' 2>&1 | grep -q 'OK'; then
    echo -e "\e[1;32mPASS: $1\e[0m"
    ((PASS++))
  else
    echo -e "\e[1;31mFAIL: $1\e[0m"
    ((FAIL++))
  fi
}

# Header
echo "=== Neovim Config Integration Test ==="

# Test config modules (safe without plugins)
test_module "config.options" "require('config.options')"
test_module "config.keymaps" "require('config.keymaps')"
test_module "config.layouts" "require('config.layouts')"

# Test plugin modules load (without executing setup)
test_table_exists "plugins.snacks" "require('plugins.snacks')"
test_table_exists "plugins.lsp" "require('plugins.lsp')"
test_table_exists "plugins.dap" "require('plugins.dap')"
test_table_exists "plugins.completion" "require('plugins.completion')"
test_table_exists "plugins.editing" "require('plugins.editing')"
test_table_exists "plugins.ui" "require('plugins.ui')"
test_table_exists "plugins.treesitter" "require('plugins.treesitter')"
test_table_exists "plugins.opencode" "require('plugins.opencode')"
test_table_exists "plugins.mason" "require('plugins.mason')"

# Test layout functions exist
test_function_exists "layout.maximize_editor" "require('config.layouts').maximize_editor"
test_function_exists "layout.terminal_dominant" "require('config.layouts').terminal_dominant"
test_function_exists "layout.debug_mode" "require('config.layouts').debug_mode"
test_function_exists "layout.cycle_layout" "require('config.layouts').cycle_layout"
test_function_exists "layout.restore_previous" "require('config.layouts').restore_previous"
test_function_exists "layout.setup" "require('config.layouts').setup"

# Test plugin setup functions exist
test_function_exists "plugins.snacks.setup" "require('plugins.snacks').setup"
test_function_exists "plugins.lsp.setup" "require('plugins.lsp').setup"
test_function_exists "plugins.dap.setup" "require('plugins.dap').setup"
test_function_exists "plugins.completion.setup" "require('plugins.completion').setup"
test_function_exists "plugins.editing.setup" "require('plugins.editing').setup"
test_function_exists "plugins.ui.setup" "require('plugins.ui').setup"
test_function_exists "plugins.treesitter.setup" "require('plugins.treesitter').setup"
test_function_exists "plugins.opencode.setup" "require('plugins.opencode').setup"
test_function_exists "plugins.mason.setup" "require('plugins.mason').setup"

# Summary
echo -e "\n=== Test Summary ==="
echo -e "\e[1;32mPassed: $PASS\e[0m"
echo -e "\e[1;31mFailed: $FAIL\e[0m"
echo "Total: $((PASS + FAIL))"

if [ $FAIL -eq 0 ]; then
  echo -e "\e[1;32m✅ All tests passed!\e[0m"
  exit 0
else
  echo -e "\e[1;31m❌ Some tests failed!\e[0m"
  exit 1
fi
