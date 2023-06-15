#!/usr/bin/python3
from lxml import html
import requests
import sys

if len(sys.argv) != 2:
    print("USAGE: {} [ModDB URL]".format(sys.argv[0]))
    exit()

MODDB_BASE="https://mods.vintagestory.at"
MOD_URL=sys.argv[1]

moddb_page = requests.get(MOD_URL)
dom = html.fromstring(moddb_page.content)
download_url = dom.xpath("/html/body/div[4]/div[2]/div[1]/div[1]/div[2]/table/tbody/tr/td[6]/a/@href")[0]
download_file_name = dom.xpath("/html/body/div[4]/div[2]/div[1]/div[1]/div[2]/table/tbody/tr/td[6]/a/text()")[0]

mod_download = requests.get("{}{}".format(MODDB_BASE, download_url))
with open(download_file_name, 'wb') as downloaded_file:
    downloaded_file.write(mod_download.content)
