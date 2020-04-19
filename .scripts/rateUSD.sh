if [ ! -f /tmp/rate.html ]; then
	curl -s "https://www.cnbcindonesia.com/market-data/currencies/IDR=/USD-IDR" > /tmp/rate.html
fi
if [ ! -f /tmp/rateUSD.txt ]; then
	cat /tmp/rate.html | grep -A1 'class="mark_val"' | cut -d'"' -f2 | cut -d'<' -f2 | cut -d'>' -f2 > /tmp/rateUSD.txt
	sed -i "s/mark_val/Kurs USD -> IDR:/g" /tmp/rateUSD.txt
	cat /tmp/rateUSD.txt
	echo "Sumber: CNBC Indonesia"
else
	cat /tmp/rateUSD.txt
	echo "Sumber: CNBC Indonesia"
fi
