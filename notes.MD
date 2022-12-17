# Shell scripting book notes

## Chapter 1 - Intro

### Examples of logical operators and outcome
#

`OR` - `command2` is executed only if `command1` exits with status code `other` than 0

```sh
command1 || command2
```

`AND` - `command2` is executed only if `command1` exists with status code 0

```sh
command1 && command2
```

Read last status code

```sh
echo $1
```

### Working with arguments
#

`$0` - name of the script itself and it is often used in usage statements

`$1` - positional argument, `1st_argument` passed to the script
- the other arguments can be retrieved with $n where n is the number of the argument passed

`${10}` - this is the formula where 2 or more digits are required to represent the argument position

`$#` - argument count - useful when we need to set the amount of args needed for correct script execution

`$*` - refers to all args

### Other tricks
#

Escape keywords by using `\` and double qoutation marks `""` and not single quotation marks `''`

```sh
echo "$USER earns \$4" 
```

Printing the name of the command - Syntax $(..) is used to evaluate `output of inner command`

```sh
echo "You are using $(basename $0)"
```

Alternative using `single qoutes` ''

```sh
echo "You are using 'basename $0'"
```

Changing the shell environment

```sh
exec zsh
exec bash
```

### Debugging scripts
#

Flag `-v` will output verbose info (line by line)

```sh
bash -v hello2.sh Fred
```

Flag `-x` will output commands as they are executed

```sh
bash -x hello2.sh Fred
```

## Chapter 2 - Creating Interactive Scripts

Using echo with options. Supressing the new line by using either `-n` or `-e` flag

```sh
echo -n "Which dir do you want to use? "
echo -e "Which dir do you want to use? \c"
```

### Using read
#

The name `var` will be populated with the entered prompt. Does not work with `zsh`, only in `bash`.

```sh
read -p "Enter your name: " name
echo $name
```

Syntax for reading to variable

```sh
read -p <prompt> <variable_name>
```

Limiting the no. of entered chars

```sh
read -n1 -p "Press any key to exit"
```

ZSH way - First you need to print a prompt and then read

```sh
printf >&2 '%s' 'Erase all directories? (y/n)'
read ans
```

## Chapter 3 - Conditionals Attached

### Simple decision paths using command-line lists (using the `test` command)
#

Command-line lists: 2 or more statements that are joined using either AND or OR notations

Test if a script is run from user's home dir

```sh
test $PWD == $HOME || cd $HOME
```

Test if a user is `pi` and then write a message to his console

```sh
who | grep pi ? /dev/null 2>&1 write pi < message.txt
```

### Verifying user input with lists (using the `test` command)
#

Tests if there exists a first argument then execute 2nd command

```sh
test -z $1 || echo "Hello $1"
```

### Using the test shell builtin

```sh
test EXPRESSION
test !EXPRESSION
```

If we want to include multiple expressions, we could do it with AND `(-a) `and OR `(-o)`

```sh
test EXPRESSION -a EXPRESSION
test EXPRESSION -o EXPRESSION
```

The following has the same meaning [SHORTHAND VERSION]

```sh
[ EXPRESSION -a EXPRESSION ]
```

### Testing strings
#

- Test if user is root

```sh
test $USER = root
[ $USER = root ]
```

- Test if user is connected via SSH by verifying the SSH_TTY variable in user env

```sh
test -n $SSH_TTY
[ -n $SSH_TTY ]
```

- Test is a `string is non-zero`

```sh
test -z $1
[ -z $1 ]
```

### Testing integers
#

Testing if no. of positional arg is greater than 0

```sh
[ $# -gt 0]
[ $# -eq 1]
```

### Testing file types
#

We can also test for the existence of a file or file type. e.g We want to delete a file only if it is s symbolic link

The `/usr/src/linux` dir is a symbolic link to the latest kernel source code. As we want to compile a new kernel and link it to this folder, we have to delete this symbol link first.

```sh
[ -h /usr/src/linux ] && rm /usr/src/linux
```

Options to verify for different file types

- -d: directory
- -e: file exists in any form
- -x: executable file
- -f: regular file
- -r: readable file
- -p: file is named pipe
- -b: file is block device
- -c: file is char device

### Creating conditonals statements usinf if
#

- Example can be found in /bin/hello5.sh

Syntax:

```sh
if condition ; then 
 statement1
 statement2
fi
```

### Extending if with else

Syntax:

```sh
if condition ; then
 statement
else
 statement
fi
```

### Using case statements

In bash we can use the '`case`' statement to test for simple values, such as int or strings

Syntax:

```sh
case expression in
    case1)
        statement1
        statement2
    ;;
    case2)
        statement1
        statement2
    ;;
    *)
        statement1
    ;;
esac
```

### Building a front-end with grep

```sh
usage="Usage: search.sh file string operation"

if [ ! "$#" = 3 ] ; then
	echo "$usage"
	exit 2
fi

# Check if $3 is a file
[ ! -f $1 ] && exit 3

case $3 in 
	[cC])
		msg="Counting matches in $1 of $2"
		opt="-c"
		;;
	[pP])
		msg="Print the matches of $2 in $1"
		opt="-p"
		;;
	[dD])
		msg="Printing all the lines but those matching $3 from $1"
		opt="-v"
		;;
	*)
		echo "Could not evaluate $1 $2 $3"
		;;
esac

echo $msg
grep $opt $2 $1
```

## Chapter 4 - Creating code snippets


In this chapter you will learn about:

- Creating abbreviations in `.vimrc`
- Reading snippets with vim text editor
- Using color in terminal

### Abbreviations
#

The abbreviations will be written in the `.vimrc` file and as soon as you type the last char and space or newline, the abbreviations will expand to the shortcut

Syntax:

```sh
abbr <shortcut> <string>
```

E.g.

```sh
abbr _sh #/bin/bash
```

### Using code snippets
#

Code is snippets is code prepared that can be read into the current script. Using `vim`, we can easily read the contents of other files while editing.

```sh
ESC
:r <path-and-filename>
```

E.g. Read the if snippet from the snippets folder

```sh
ESC
:r $HOME/snippets/if
```

It is not required to share the dir with other users, so it can be made private

```sh
mkdri -m 700 $HOME/snippets
```

### Bringing color to the terminal

We can display colored text by using the `-e` option with echo. The colors can be written directly or stored in variables.

The variables can be stored in `$HOME/snippets/color` and invoked at runtime by using source 
```sh
source $HOME/snippets/color
```

File contents of: `$HOME/snippets/color`
```sh
RED="\033[31m"
GREEN="\033[32m"
BLUE="\033[34m"
RESET="\033[0m"
```

`RESET` is used to go back to the default text color

E.g.
```sh
echo -e "${RED}$USER is logged in ${RESET}"
```

## Chapter 5 - Alternative Syntax

In this chapter, we will look at:

- Test conditionals
- Providing parameters defaults
- When in doubt - qoute!
- Advanced tests using `[(`
- Arithmetic operations using `((`

### Testing files
#

Test existance of a file using `-e`. Or test if it is a regular file by the `-f` option.

[Test command man page](https://ss64.com/bash/test.html)

```sh
test -e /etc/hosts
test -f /etc/hosts
```

N.B. Check return code by `echo $?`

#### Adding logic
#

`-o` => OR

`-a` => AND

Test if the `/etc/hosts` file is a regular file `AND` is has read permision.

```sh
test -f /etc/hosts -a -r /etc/hosts
```

### Square brakets as not seen before
#

Replacing the test command with the square brackets. Using the previous example, now we will transform it using square brakets.

```sh
[ -f /etc/hosts -a -r /etc/hosts ]
```

Another example but in this one, we are using variables

```sh
FILE=/etc/hosts
[ -f $FILE -a -r $FILE ] && cat $FILE
```

### Providing parameter defaults
#

#### `Variables`

Variables are one type of parameter which can be set by the system or by ourselves. They can be read with the `$` symbol before the variable.

e.g. `$USER`

#### `Special parameters`

Special parameters are the second parameter type and are managed by the shell itself and are presented as `read-only`. 

```sh
echo "My shell is $0 and the shell options are: $-"
```

The option `$-` represents the shell options that are configured. These can be displayes using the `set -o` command but it can be read programatically using `$-`.

### Setting defaults
#

Parameter substitution example syntax (`Anonymus` being the default value):

```sh
${parameter-default}
name=${1-"Anonymus"}
```

### When in doubt - Quote!
#

The correct term that we should use for reading the value of the value of parameters is `parameter expansion`. The `$` symbol is used to allow the expansion of the parameter.

So in the case of a parameter name that includes spaces e.g. `my file`, the parameter expansion operation will output 2 arguments `my` , `file` instead of a single name.

It can be mittigated by quoting the the argument when used.

```sh
FILE="my file"
[ -f "$FILE" -a -r "$FILE" ] && cat "$FILE"
```

### Advanced test using `[[`
#

#### Whitespace

Reconsidering the condition we tested earlier, we can `omit the quotes` when using [[, as shown in the following example. Note that you can also use `&&` and `||` to represent AND and OR respectively.

```sh
echo "The file contents">"my file"
FILE="my file"
[[ -f $FILE && -r $FILE ]] && cat "$FILE"
```

#### Other advanced features

Pattern maching. The following example will copy only the `.pl` file to the scripts folder.

```sh
[[ $FILE = *.pl ]] && cp "$FILE" scripts/
```

Regular expressions. We can also use regex with the `[[`

```sh
[[ $FILE = ~\.pl$ ]] && cp "$FILE" scripts/
```

### Regular expression script
#

```sh
#!/bin/bash

# Turn off case sensitivity
shopt -s nocasematch
read -p "Type color or mono for script output: "
if [[ $REPLY =~ colou?r ]] ; then
	source $HOME/snippets/color
fi

# Where parameters are not set, the display will be mono
echo -e "${GREEN} This is $0 $RESET"
# Reset case sensitivity
shopt -u nocasematch
exit 0
```

 `if [[ $REPLY =~ colou?r ]] ; then` 
 
 The regular expression caters to both spellings of color by making the u optional: `u?`. Furthermore, we can disable case sensitivity allowing for COLOR and color by setting a shell option: 
 
 `shopt -s nocasematch`

### Arithmetic operations using `((`
#

When using bash and some other advanced shells, we may make use of the `(( ))` notation to simplify mathematical operations with scripts.

Simple math.

```sh
a=(( 2 + 3))
let a=2+3
```

Parameter manipulation.

```sh
COUNT=1
(( COUNT++ ))
echo $COUNT

#or
(( COUNT=COUNT+1 ))
#or
(( COUNT-- ))
#or
(( COUNT=COUNT-1 ))
```

Standard arithmetic tests. 

```sh
(( COUNT > 1 )) && echo "Counter is greater than 1"
```

## Chapter 6 - Iterating with loops

In this chapter we will cover:
- `for` loops
- Loop control
- `while` and `until`
- Read from file
- Creating operator menu

### For loops
#

Example of a for loop (iterating over the 2 elements). Following examples adds users bob and joe and asks for their password.

```sh
for u in bob joe ; do
	useradd $u
	echo '$u:Password1' | chpasswd
	passwd -e $u
done
```

or printing the `inode metadata` by using the `stat` command

```sh
for f in * ; do
	stat "$f"
done
```

### Controlling the loop
#

The `break` keyword is used to exit the loop, processing no more entries, whereas the `continue` keyword is used to stop the processing of the current entry lsand resume the processing with the next entry.

By using the following program we want to set permisions, but for directories only.

```sh
for f in * ; do
	[ -d "$f" ] || continue
	chmod 777 "$f"
done
```

Print the first directory encountered

```sh
for f in * ; do
	[ -d "$f" ] && break
done
echo "We have found a directory $f"
```

The following program searches the current directory for other files which are directories and `appends` them to the `dir_name` list

```sh
for f in * ; do 
	[ -d "$f" ] || continue
	dir_name="$dir_name $f"
done
echo "$dir_name"
```

### While loop and until loops
#

When using the for loop we iterate through a `list` (important concept), it's either the one that we create or the one that is dynamically generated. Using the while or until loops, we loop based on the fact that `the condition` becomes either true or false.

A `while loop` loops while the condition is true and conversely an `until loop` will loop while the condition is false.

```sh
COUNT=10
while ((COUNT >= 0)) ; do
	echo -e "$COUNT \c"
	(( COUNT-- ))
done ; echo
```

**Note**:The use of the `\c` escape sequence used here allows the suppression of the line-feed normally used with echo.

Now using the `until` loop

```sh
COUNT=10
until ((COUNT < 0)) ; do
echo -e "$COUNT \c"
((COUNT--))
done ; echo
```

### Reading input from files
#

The shell built-in `read` command that we saw earlier in this book can be used to read a file line by line. In this way, we can use a loop to process each line of a file.


The following program reads a server IP from a file an pings it to check if it is up and running, then adds it to a file

```sh
if [ ! -f "$1" ] ; then
	echo "The input to $0 should be a filename"
	exit 1
fi

echo "The following servers are up on $(date +%x)" > server.out

while read server
do
	ping -c1 "$server" && echo "Server up: $server" >> server.out
done < $1
cat server.out
```

### Creating operator menus
#

Example

```sh
while true ; do
    clear
    echo "Choose an item: a, b, or c"
    echo "a: Backup"
    echo "b: Display calendar"
    echo "c: Exit"
    read -sn1
    case "$REPLY" in
        a) tar fczP $HOME/backup.tgz ${HOME}/bin;;
        b) cal;;
        c) exit 0;;
    esac
    read -n1 -p "Press any key to continue"
done
```

## Chapter 7 - Creating building blocks with functions

In this chapter we will cover:
- Functions
- Passing arguments to functions
- Returning values

### Functions

Functions are blocks of code that exist in memory as named elements. To display the functions residing in the shell environment, you can use `declare -F`.

By using the `-f <function_name>` flag, you also display the associated definition. To only display the definition for a specific function, use: `type <function_name>`

Syntax of function

```sh
function <function_name> {
	<code_to_execute>
}
```

Example of function to display system information:

```sh
function show_system {
	echo "The uptime is:"
	uptime; echo
	echo "CPU details:"
	lscpu; echo
	echo "User list:"
	who
}
```

### Passing parameters to functions

Earlier within this chapter, we referred to functions as scripts within scripts and we will still maintain that analogy.

One liner to remove comment lines using sed

```sh
sed -i.bak '/^\s*#/d;/^$/d' <filename>
```

Breaking down the command:
- `sed -i.bak` - It edits the file and creates a backup file (with extension.bak) of the original which can be accessed at `<file_name>.bak`.
- `/^` - Lines that start with, that is the first character of the line.
- `\s*` - This means any amount of white space including no spaces or tabs.
- `#/` - Followed by the comment. Altogether `/^\s*#/` we are looking for lines that begin with a comment or spaces and a comment.
- `d` - The action delete to remove matching lines.
- `;/^$/d` - The semi-colon is used to separate expressions and the second expression is similar to the first but this time we are preparing to delete empty lines or lines that being with the end of line marker $.

```sh
function clean_file {
	sed -i.bak '/^\s*#/d;/^$/d' $1
}
```

The following are the detailed steps we need to follow to perform the test on the new function:

1. Create the `clean_file` function as described.
2. Move to your home directory using the cd command without arguments.
3. Copy the time configuration file to your home directory: `cp /etc/ntp.conf $HOME`.
4. Count the number of lines in the file with the following command: `wc -l $HOME/ntp.conf`.
5. Now, remove the commented and empty lines with: `clean_file $HOME/ntp.conf`.
6. Now, recount the lines using: `wc -l $HOME/ntp.conf`.
7. From the backup of the original that we created: `wc -l $HOME/ntp.conf.bak`.

### Returning values from functions

```sh
function to_lower {
    output=$(tr [A-Z] [a-z] <<<"$1")
return $output
}
```

Stepping through the code we can begin to understand the operation of this function:
- `output=$(tr [A-Z] [a-z] <<< "$1")` - This is the main engine of the function where the translation from upper case to lower case occurs. 
- The use of the here string operator `<<<` allows us to expand the variable to read in to the contents to the `tr` program. This is a form of input redirection.
- `return $output`: This is how we create the return value.”

## Chapter 8 - Introducing SED
