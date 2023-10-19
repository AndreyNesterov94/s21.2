#!/bin/bash

log_file="files.log"
string="$string"
new_string="$string2"

# Проверка наличия аргументов
if [ $# -ne 3 ]; then
    echo "Usage: $0 <file> <string> <new_string>"
    exit 1
fi

# Проверка наличия файла
file="$1"
if [ ! -f "$file" ]; then
    echo "Файл не найден: $file"
    exit 1
fi

# Замена строки
awk -v find="$string" -v replace="$new_string" '{gsub(find, replace)}1' "$file" > tmp_file && mv tmp_file "$file"
exit_code=$?

# Информация о файле
size=$(wc -c < "$file")
date=$(date -r "$file" +"%Y-%m-%d %H:%M")
sha_sum=$(shasum -a 256 "$file" | awk '{print $1}')

# Запись в журнал с форматированием
printf "src/%s - %d - %s - %s - sha256\n" "$file" "$size" "$date" "$sha_sum" >> "$log_file"

if [ $exit_code -ne 0 ]; then
    echo "Failed" >> "$log_file"
fi