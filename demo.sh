start_with_a(){
    [[ $1 == [aA]* ]]
    echo $?
}

if start_with_a A; then
    echo "hiha"
else
    echo "nono"
fi