# Shell scripting book notes

## Chapter 1 - Intro

Command2 is executed only if command1 exits with status code other than 0

```sh
command1 || command2'
```

Command 2 is executed only if command1 exists with status code 0

```sh
command1 && command 2
```

Read last status code

```sh
echo $1
```

## Working with arguments

`$0` - name of the script itself and it is often used in usage statements

`$1` - positional argument, 1st argument passed to the script

`${10}` - where 2 or more digits are required to represent the argument position

`$#` - argument count - useful when we need to set the amount of args needed for correct script execution

`$*` - refers to all args

Escape keywords by using `\` and double qoutation marks `""` and not `''`

```sh
echo "$USER earns \$4" 
```

Printing the name of the command - Syntax $(..) is used to evaluate output of inner command

```sh
echo "You are using $(basename $0)"
```

Alternative using single qoutes ''

```sh
echo "You are using 'basename $0'"
```

## Debugging scripts

Output verbose info (line by line) by using `-v`

```sh
bash -v hello2.sh Fred
```

Will output commands as they are executed

```sh
bash -x hello2.sh Fred
```

## Chapter 2 - Creating Interactive Scripts

Using echo with options. Supressing the new line

```sh
echo -n "Which dir do you want to use? "
echo -e "Which dir do you want to use? \c"
```

### Using read

The name var will be populated with the entered prompt. Does not work with ZSH

```sh
read -p "Enter your name: " name
echo $name
```

`'-p'` option syntax

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

### Simple decision paths using command-line lists

Command-line lists: 2 or more statements that are joined using either AND or OR notations

Test if a script is run from user's home dir

```sh
test $PWD == $HOME || cd $HOME
```

Test if a user is "username" and then write a message to his console

```sh
who | grep pi ? /dev/null 2>&1 write pi < message.txt
```

### Verifying user input with lists

Tests if there exists a first argument then exec 2nd command

```sh
test -z $1 || echo "Hello $1"
```

### Using the test shell builtin

```sh
test EXPRESSION
test !EXPRESSION
```

If we want to include multiple expressions, we could do it with AND (-a) and OR (-o)

```sh
test EXPRESSION -a EXPRESSION
test EXPRESSION -o EXPRESSION
```

The following has the same meaning (SHORTHAND VERSION]

```sh
[ EXPRESSION -a EXPRESSION ]
```

### Testing strings

- Test if user is root
$ test $USER = root
$ [ $USER = root ]

- Test if user is connected via SSH by verifying the SSH_TTY variable in user env
$ test -n $SSH_TTY

- Test is a string is non-zero
$ test -z $1
$ [ -z $1 ]

### Testing integers

Testing if no of positional arg is greater than 0

```sh
[ $# -gt 0]
[ $# -eq 1]
```

### Testing file types

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

## Creating conditonals statements usinf if

- Example can be found in /bin/hello5.sh

Syntax:

```sh
if condition ; then 
 statement1
 statement2
fi
```

## Extending if with else

Syntax:

```sh
if condition ; then
 statement
else
 statement
fi
```

### Using case statements

In bash we can use the 'case' statement to test for simple values, such as int or strings

## Chapter 4 - ...