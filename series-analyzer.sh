#!/bin/bash

echo "======================"
echo "start series anazlyzer" 
echo "======================"


# Function to validate that all inputs are positive numbers
validate_series() {
    for num in "$@"
	do
        if ! [[ $num =~ ^[0-9]+$ ]]; then
            echo "Invalid input: $num is not a positive number."
			return 1
        fi
    done
	return 0
}

# Check if the series was passed as command-line arguments
if [[ $# -ge 3 ]]
then
	series=("$@")
    if validate_series ${series[@]}
	then
        echo "Series accepted: ${series[@]}"
    else
        echo "Please enter a valid series."
    fi

else
 echo "No valid series provided."

while true; 
do
        read -p "Enter at least 3 positive numbers (separated by spaces): " -a commandLineSeries
        if [[ ${#commandLineSeries[@]} -ge 3 ]] && validate_series "${commandLineSeries[@]}"
		then
            echo "command line Series accepted: ${commandLineSeries[@]}"
			series=(${commandLineSeries[@]})
            break
        else
            echo "Invalid input. Please try again."
        fi
    done
fi


# Displaying menu


options=(
"input_a_series" 
"display_order_series"
"display_sorted_series" 
"display_max_value_series" 
"display_min_value_series"
"display_avg_series" 
"display_num_of_elem_in_series"
"exit"
)

input_a_series(){
while true
do
        read -p "Enter at least 3 positive numbers (separated by spaces): " -a series
        if [[ ${#series[@]} -ge 3 ]] && validate_series ${series[@]}
		then
            echo "Series replaced: ${series[@]}"
            break
        else
            echo "Invalid input. Please try again."
        fi
done
}


display_order_series(){
  echo "Series: ${series[@]}"
}


display_sorted_series(){
	sorted_series=($(for i in ${series[@]}; do echo $i; done | sort -n))
	echo "Sorted Series: ${sorted_series[@]}"
}

display_max_value_series(){
	max_value=${series[0]}

    for num in ${series[@]}
	do
        if (( num > max_value )); then
            max_value=$num
        fi
    done

	echo "max value in the series: $max_value"
}

display_min_value_series(){
	min_value=${series[0]}

    for num in ${series[@]}
	do
        if (( num < min_value )); then
            min_value=$num
        fi
    done

	echo "min value in the series: $min_value"
}

display_avg_series(){
	sum=0

	for ele in ${series[@]}
	do
	let sum=sum+ele
	done

	len=${#series[@]}

	# Bash does not support floating-point arithmetic, so Calculate average with floating-point precision
    avg=$(echo "scale=2; $sum / $len" | bc)

	echo "avg of the series is : $avg"

}

display_num_of_elem_in_series(){

	echo ${#series[@]}

}





select option in "${options[@]}"
do
	case $REPLY in
	1)
		input_a_series;;
           
	2)
		display_order_series;;
	3)
		display_sorted_series;;

	4)
		display_max_value_series;;
	5) 
		display_min_value_series;;
	6)
		display_avg_series;;
	7)
	 	display_num_of_elem_in_series;;

	exit)
        echo "Exiting...."
        break ;;

	 *)
        echo "Invalid option. Please try again.";;

	esac
done