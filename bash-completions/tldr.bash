#!/bin/bash

BUILTIN_THEMES="single base16 ocean"

OS_TYPES="linux osx sunos windows"

OPTIONS='-V
--version
-l
--list
-a
--list-all
-1
--single-column
-r
--random
-e
--random-example
-f
--render
-m
--markdown
-o
--linux
--osx
--sunos
--windows
-t
--theme
-s
--search
-u
--update
-c
--clear-cache
-h
--help'

function _tldr_autocomplete {
  OPTS_NOT_USED=$( comm -23 <( echo "$OPTIONS" | sort ) <( printf '%s\n' "${COMP_WORDS[@]}" | sort ) )

  cur="${COMP_WORDS[$COMP_CWORD]}"
  COMPREPLY=()
  if [[ "$cur" =~ ^-.* ]]
  then
    COMPREPLY=(`compgen -W "$OPTS_NOT_USED" -- $cur`)
  else
    if [[ $COMP_CWORD -eq 0 ]]
    then
      prev=""
    else
      prev=${COMP_WORDS[$COMP_CWORD-1]}
    fi
    case "$prev" in
      -f|--render)
        COMPREPLY=(`compgen -f $cur`)
        ;;

      -o|--os)
        COMPREPLY=(`compgen -W "$OS_TYPES" $cur`)
        ;;

      -t|--theme)
        # No suggestions for these, they take arbitrary values
        SUGGESTED_BUILTINS=(`compgen -W "$BUILTIN_THEMES" $cur`)
        if [[ ${#SUGGESTED_BUILTINS[@]} -eq 0 ]]
        then
          COMPREPLY=()
        else
          COMPREPLY=("<custom theme name>" "${SUGGESTED_BUILTINS[@]}")
        fi
        ;;

      -s|--search)
        # No suggestions for these, they take arbitrary values
        COMPREPLY=("")
        ;;

      *)
        sheets=$(tldr -l -1)
        COMPREPLY=(`compgen -W "$sheets $OPTS_NOT_USED" -- $cur`)
        ;;
    esac
  fi
}

complete -F _tldr_autocomplete tldr
