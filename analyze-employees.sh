#!/bin/bash
# analyze-employees.sh
# Reads a CSV file of employees and prints a summary.

FILE="${1:-employees.txt}"

if [ ! -f "$FILE" ]; then
    echo "❌ Error: File '$FILE' not found!"
    echo "Usage: $0 <csv-file>"
    exit 1
fi

echo "=========================================="
echo "  Employee Analysis Report"
echo "=========================================="
echo ""

# Total employees (count non-empty lines)
TOTAL=$(grep -c "." "$FILE")
echo "📊 Total Employees: $TOTAL"

# Average salary (awk sum / count)
AVG=$(awk -F, '{sum += $3; count++} END {printf "%.2f", sum/count}' "$FILE")
echo "💰 Average Salary: ₱$AVG"

# Highest paid employee
HIGHEST=$(awk -F, 'BEGIN {max=0} $3 > max {max=$3; name=$1} END {print name" (₱"max")"}' "$FILE")
echo "🏆 Highest Paid: $HIGHEST"

echo ""
echo "----- DevOps Team -----"
grep "DevOps" "$FILE" | awk -F, '{print "  • "$1" - ₱"$3}'

echo ""
echo "----- Developers -----"
grep "Developer" "$FILE" | awk -F, '{print "  • "$1" - ₱"$3}'

echo ""
echo "----- All Roles (DevOps → SRE via sed) -----"
sed 's/DevOps/SRE/g' "$FILE" | awk -F, '{print "  "$1": "$2}'

echo ""
echo "=========================================="
Gawing executable at i-test:

bash
chmod +x analyze-employees.sh

# Create test data
cat > employees.txt <<EOF
Juan,DevOps,50000
Maria,Developer,60000
Pedro,DevOps,55000
Ana,Manager,80000
Luis,Developer,58000
EOF

# Run
./analyze-employees.sh
