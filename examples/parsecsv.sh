#!/bin/bash

OLDIFS="$IFS"
IFS=","
while read product price quantity
do
echo -e "Product : \t $product \n\
Price : \t $price \n\
Quantity : \t $quantity \n\n"

done <"$1"
IFS=$OLDIFS