# get rate value from cnbcindonesia.com
[ ! -f /tmp/rateUSD.txt ] && curl -s "https://www.cnbcindonesia.com/market-data/currencies/IDR=/USD-IDR" | grep -A1 'class="mark_val"' | cut -d'"' -f2 | cut -d'<' -f2 | cut -d'>' -f2 > /tmp/rateUSD.txt
# if rateUSD.txt exist then display it while replace mark_val with Kurs USD -> IDR:
[ -f /tmp/rateUSD.txt ] && sed 's/mark_val/Kurs USD -> IDR:/' /tmp/rateUSD.txt; echo "Sumber: CNBC Indonesia"
