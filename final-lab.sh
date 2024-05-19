format_price() {
    printf "%'.2f\n" "$1"
}

format_percentage() {
    printf "%.0f\n" "$1"
}

echo -e "Sales Input:\n\n"

echo -n "Enter Product 1: "
read product_1
echo -n "Enter Price: "
read product_1_price

echo -n "Enter Product 2: "
read product_2
echo -n "Enter Price: "
read product_2_price

echo -n "Enter Product 3: "
read product_3
echo -n "Enter Price: "
read product_3_price

echo -e "\n\nInput Mode of Payment Terms\n\n"

echo -n "Cash Discount: "
read cash_discount
echo -e "\tYou input $(format_percentage "$cash_discount")% Discount for Cash"

echo -n "3 Months Installment: "
read three_months
echo -e "\tYou input $(format_percentage "$three_months")% Interest for 3 Months Installment"

echo -n "6 Months Installment: "
read six_months
echo -e "\tYou input $(format_percentage "$six_months")% Interest for 6 Months Installment"

echo -n "12 Months Installment: "
read twelve_months
echo -e "\tYou input $(format_percentage "$twelve_months")% Interest for 12 Months Installment"

echo -e "\n\nMain Menu"
echo -e "Press I/i: $product_1\t\t\$$product_1_price"
echo -e "Press S/s: $product_2\t\t\$$product_2_price"
echo -e "Press X/x: $product_3\t\t\$$product_3_price"

echo -n -e "\n\nEnter Item: "
read item

case $item in
    [Ii])
        selected_product=$product_1
        selected_price=$product_1_price
        ;;
    [Ss])
        selected_product=$product_2
        selected_price=$product_2_price
        ;;
    [Xx])
        selected_product=$product_3
        selected_price=$product_3_price
        ;;
    *)
        echo "You have entered a wrong input"
        exit 1
        ;;
esac

echo -e "\nYour Item is $selected_product"
echo "Price: $(format_price "$selected_price")"

echo -e "\nSelect Mode of Payment"
echo -e "\nPress 1: Cash\t\t\t$(format_percentage "$cash_discount")% Discount"
echo -e "Press 2: 3 Months Installment\t$(format_percentage "$three_months")% Interest"
echo -e "Press 3: 6 Months Installment\t$(format_percentage "$six_months")% Interest"
echo -e "Press 4: 12 Months Installment\t$(format_percentage "$twelve_months")% Interest"

echo -n -e "\n\nEnter Mode of Payment: "
read mode_of_payment

case $mode_of_payment in
    1)
        discount_interest_percentage=$(awk "BEGIN {print $cash_discount / 100}")
        discount_interest=$(awk "BEGIN {print $selected_price * $discount_interest_percentage}")
        total_amount=$(awk "BEGIN {print $selected_price - $discount_interest}")
        monthly_amortization=0
        ;;
    2)
        discount_interest_percentage=$(awk "BEGIN {print $three_months / 100}")
        discount_interest=$(awk "BEGIN {print $selected_price * $discount_interest_percentage}")
        total_amount=$(awk "BEGIN {print $selected_price + $discount_interest}")
        monthly_amortization=$(awk "BEGIN {print $total_amount / 3}")
        ;;
    3)
        discount_interest_percentage=$(awk "BEGIN {print $six_months / 100}")
        discount_interest=$(awk "BEGIN {print $selected_price * $discount_interest_percentage}")
        total_amount=$(awk "BEGIN {print $selected_price + $discount_interest}")
        monthly_amortization=$(awk "BEGIN {print $total_amount / 6}")
        ;;
    4)
        discount_interest_percentage=$(awk "BEGIN {print $twelve_months / 100}")
        discount_interest=$(awk "BEGIN {print $selected_price * $discount_interest_percentage}")
        total_amount=$(awk "BEGIN {print $selected_price + $discount_interest}")
        monthly_amortization=$(awk "BEGIN {print $total_amount / 12}")
        ;;
    *)
        echo "You have chosen a wrong input."
        exit 1
        ;;
esac

payment_mode=$(case $mode_of_payment in 1) echo "Cash";; 2) echo "3 Months Installment";; 3) echo "6 Months Installment";; 4) echo "12 Months Installment";; esac)

echo "Mode of Payment: $payment_mode"
echo "Item is: $selected_product"
echo "Price: $(format_price "$selected_price")"
echo "Discount/Interest: $(format_price "$discount_interest")"
echo "Total Amount: $(format_price "$total_amount")"
echo "Monthly Amortization: $(format_price "$monthly_amortization")"

# Used my old Java Code in of the Cellphone.java as reference to make the bash.
