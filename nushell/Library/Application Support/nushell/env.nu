# Nushell Environment Config File

def create_left_prompt [] {
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)"
    } else {
        $"(ansi green_bold)($env.PWD)"
    }

    $path_segment
}

def create_right_prompt [] {
    let time_segment = ([
        (date now | format date '%m/%d/%Y %r')
    ] | str join)

    $time_segment
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { || create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = "〉"
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
$env.VISUAL = "hx"
$env.EDITOR = $env.VISUAL
$env.GIT_EDITOR = $env.VISUAL

# $env.PAGER = "less"

$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/.cargo/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/.local/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/.rustup/toolchains/stable-aarch64-apple-darwin/bin/')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/reports')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/opt/llvm/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/usr/local/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/.pyenv/shims')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/usr/local/texlive/2021/bin/universal-darwin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/.rd/bin')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/Users/jharder/Kipsu/ansible-wrapper')
$env.PATH = ($env.PATH | split row (char esep) | prepend '/usr/local/go/bin')
# $env.PATH = ($env.PATH | split row (char esep) | prepend $"(go env GOPATH)/bin")
$env.PATH = ($env.PATH | split row (char esep) | prepend '/opt/homebrew/opt/go@1.23/bin')

$env.GITHUB_KEY = '/Users/jharder/.ssh/docker_github'
$env.OBJC_DISABLE_INITIALIZE_FORK_SAFETY = 'YES'
$env.TERM = "xterm-256color"
$env.VIFM = '/Users/jharder/.config/vifm'
$env.MAIL_ACCOUNT = 'work'

$env.XDG_CONFIG_HOME = '/Users/jharder/.config/'
