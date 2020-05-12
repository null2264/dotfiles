curl -s "https://isitup.org/elearning.binadarma.ac.id" > /tmp/isitup.html

cat /tmp/isitup.html | grep "data-text" | cut -d'"' -f2 > /tmp/isitup.txt

cat /tmp/isitup.txt
