#!/bin/bash

# Script to fix deprecated withOpacity to withValues

echo "Fixing deprecated withOpacity..."

# Find and replace in all Dart files
find lib -name "*.dart" -type f -exec sed -i 's/\.withOpacity(\([0-9.]*\))/.withValues(alpha: \1)/g' {} +

echo "Done! All withOpacity replaced with withValues"
