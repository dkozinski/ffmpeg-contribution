#!/bin/bash
astyle --style=kr --remove-braces --indent=spaces=4 --min-conditional-indent=1 --pad-oper --align-pointer=name --align-reference=name $1
