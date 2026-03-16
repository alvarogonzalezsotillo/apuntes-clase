


# printf "GET /v1/create-qr-code/?data=\textit{eltextoquequeramosverenelqr} HTTP/1.1\r\nHost: api.qrserver.com\r\n\r\n" | nc --no-shutdown --idle-timeout 2 api.qrserver.com 80 | tail -n +13 > qr.png


printf "GET /v1/create-qr-code/?data=\textit{eltextoquequeramosverenelqr} HTTP/1.1\nHost: api.qrserver.com\n\n" | nc --no-shutdown --idle-timeout 2 api.qrserver.com 80 | tail -n +13 > qr.png
