#!/bin/bash

# Проверка наличия аргументов
if [ $# -ne 1 ]; then
    echo "Usage: $0 <log>"
    exit 1
fi

log_file="$PWD/$1"

# Проверка наличия файла журнала
if [ ! -f "$log_file" ]; then
    echo "Файл журнала не найден: $log_file"
    exit 1
fi

# Анализ файла журнала
total_entries=$(wc -l < "$log_file")
uniq_files=$(awk '{print $1}' "$log_file" | sort | uniq | wc -l)
change_hashes=$(awk '{print $8}' "$log_file" | sort | uniq | wc -l)

# Вывод результатов анализа
echo "Общее количество записей: $total_entries"
echo "Количество уникальных файлов: $uniq_files"
echo "Количество изменений, приведших к изменению hash файла: $change_hashes"