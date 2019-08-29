#!/bin/bash

blacklistArray=()
BASEDIR=$(dirname "$BASH_SOURCE")
BLACKLISTNAME="blacklist.txt"
BLACKLIST=$BASEDIR/$BLACKLISTNAME

#echo $BLACKLIST

function readBlacklist() {
  if [ ! -f "$BLACKLIST" ] ; then
    return 1
  fi 

  while read LINE
  do 
    blacklistArray+=("${LINE}")
  done < $BLACKLIST
  #printf '%s\n' "${blacklistArray[@]}"
}

function loop() {
    ## Do nothing if * doesn't match anything.
    ## This is needed for empty directories, otherwise
    ## "foo/*" expands to the literal string "foo/*"/
    shopt -s nullglob

    found=0

    for repo in "$@"/*
    do
      ## Check if blacklist contains repo
      for i in "${blacklistArray[@]}"
      do
        if [ "$i" == "${repo}" ] ; then
          found=1
          break
        fi
      done

      ## if not, pull form git
      if [ "$found" -eq 0 ] ; then
        cd "$repo"
        printf 'COLLECTING REPO %s\n' "${PWD##*/}"
        git pull
      else
        found=0
      fi
    done
}

readBlacklist

loop "$HOME/git"
