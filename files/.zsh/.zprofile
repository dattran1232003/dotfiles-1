export UNISONLOCALHOSTNAME="lol3.roaming.nemo157.com"

function () {
  set_locale () {
    if (locale -a | grep "$1" >/dev/null) {
      export LANG="$1"
      export LC_ALL="$1"
      true
    } else {
      false
    }
  }

  set_locale en_NZ.UTF-8 || set_locale en_NZ.utf8 || set_locale en_US.UTF-8 || set_locale en_US.utf8
}

export EDITOR=vim

# grep
export GREP_OPTIONS='--color=auto'
export GREP_COLOR='38;5;108'

## Add extra paths, only if they exist and only if they're not already added.
function () {
  prepend_if_exists () {
    local var_name="$1"
    local var_value="${(e)${:-\$$var_name}}"
    local dir="$2"
    [[ -d "$dir" ]] && [[ ! "$var_value" =~ "(^|.*:)$dir(:.*|$)" ]] && export $var_name="$dir${var_value:+:}$var_value"
  }

  append_if_exists () {
    local var_name="$1"
    local var_value="${(e)${:-\$$var_name}}"
    local dir="$2"
    [[ -d "$dir" ]] && [[ ! "$var_value" =~ "(^|.*:)$dir(:.*|$)" ]] && export $var_name="$var_value${var_value:+:}$dir"
  }

  export_if_exists () {
    local var_name="$1"
    local dir="$2"
    [[ -d "$dir" ]] && export $var_name="$dir"
  }

  prepend_if_exists PATH "$HOME/bin"
  prepend_if_exists PATH "$HOME/node_modules/.bin"
  prepend_if_exists PATH "$HOME/Library/Haskell/bin"
  append_if_exists PATH "$HOME/.lein/bin"
  append_if_exists PATH "/usr/local/share/npm/bin"
  append_if_exists PATH "/usr/local/avr/bin"
  append_if_exists PATH "/usr/local/arm-eabi/bin"
  prepend_if_exists PATH "/usr/local/heroku/bin"
  append_if_exists PATH "/usr/local/Cellar/go/1.2/libexec/bin"
  append_if_exists PATH "$HOME/go/bin"

  append_if_exists PYTHONPATH "/usr/local/lib/python2.6/site-packages/"
  append_if_exists PYTHONPATH "/Library/Python/2.6/site-packages/"

  append_if_exists PERL5LIB "$HOME/bin/lib"

  append_if_exists NODE_PATH "/usr/local/lib/node_modules"
  append_if_exists NODE_PATH "$HOME/node_modules"

  append_if_exists CLASSPATH "/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar"

  if [[ -x /usr/libexec/java_home ]]
  then
    export JAVA_HOME="$(/usr/libexec/java_home)"
  fi

  export_if_exists GOPATH "$HOME/go"
  export_if_exists EC2_AMITOOL_HOME "/usr/local/Library/LinkedKegs/ec2-ami-tools/jars"
  export_if_exists EC2_HOME "/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
}

extra_config_files=(
  $HOME/.zsh/lib/pc-specific/$(hostname -s).zprofile.zsh
  $HOME/.zsh/lib/os-specific/$(uname).zprofile.zsh
  $HOME/.zsh_private/.zprofile
)

for config_file in $extra_config_files
  [[ -s $config_file ]] && source $config_file

true
