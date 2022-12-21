
# Works in zsh too
printf >&2 '%s' 'Enter a username: '
read ans
if (grep "$ans" /etc/passwd > /dev/null); then
	echo "The user $ans exists."
	exit 1
else
    echo "The user $ans does not exist."
fi