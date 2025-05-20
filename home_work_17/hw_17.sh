#!/bin/bash

read -p "Введите адрес для пинга: " HOST
FAIL_COUNT=0
while true; do
	OUTPUT=$(ping -c 1 -W 1 "$HOST" 2>/dev/null)
    if [[ $? -ne 0 ]]; then
        ((FAIL_COUNT++)) 
	echo "[!] Пинг не удался ($FAIL_COUNT/3)"
	if [[$FAIL_COUNT -ge 3 ]]; then
           echo "[!] 3 неудачные попытки пинга подряд!"
	   FAIL_COUNT=0
	fi 
    else
        # Извлекаем время пинга
        PING_TIME=$(echo "$OUTPUT" | grep 'time=' | sed -n 's/.*time=\([0-9.]*\) ms.*/\1/p')
	echo "[✓] Время пинга: ${PING_TIME} мс"
	if (( $(echo "$PING_TIME > 100" | bc -l) )); then
        echo "[!] Время пинга превышает 100 мс!"
	fi
	FAIL_COUNT=0
    fi 
    sleep 1
done
