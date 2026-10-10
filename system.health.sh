#!/bin/bash
# system-health.sh
# Displays system health: date, uptime, disk, memory, top processes.

echo "=========================================="
echo "  🩺 System Health Report"
echo "  Generated: $(date '+%Y-%m-%d %H:%M:%S')"
echo "=========================================="
echo ""

# Uptime
echo "⏱️  Uptime: $(uptime -p)"
echo "   Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo ""

# Disk usage
echo "💾 Disk Usage:"
df -h | grep -v "tmpfs" | awk 'NR==1 || $5+0 > 0 {print "   "$0}'
echo ""
echo "----- Disk Warnings -----"
df -h | grep -v "tmpfs" | awk 'NR>1 {
    usage = $5
    gsub("%", "", usage)
    if (usage > 80) {
        print "   ⚠️  WARNING: "$6" is at "$5" (over 80%)"
    }
}'
echo ""

# Memory
echo "🧠 Memory Usage:"
free -h | awk 'NR<=2 {print "   "$0}'
echo ""

# Top 5 processes by CPU
echo "🔥 Top 5 Processes by CPU:"
echo "   USER       PID  %CPU  %MEM  COMMAND"
ps aux --sort=-%cpu | awk 'NR>1 && NR<=6 {printf "   %-10s %-5s %-5s %-5s %s\n", $1, $2, $3, $4, $11}'
echo ""

echo "=========================================="
echo "  ✅ Report Complete"
echo "=========================================="
