import urllib.request
import urllib.parse
import re
import os
from io import BytesIO
from PIL import Image

queries = {
    'lebron_shoes': 'Nike LeBron 21 basketball shoes',
    'bulls_jersey': 'Chicago Bulls Michael Jordan 1998 retro red jersey',
    'curry_shoes': 'Under Armour Curry 11 basketball shoes',
    'wilson_ball': 'Wilson official NBA game basketball',
    'nba_backpack': 'Nike Hoops Elite Pro Backpack NBA',
    'lakers_tshirt': 'Los Angeles Lakers Mamba Mentality T-Shirt black'
}

assets_dir = r'c:\nba_app\assets\store'
os.makedirs(assets_dir, exist_ok=True)

req_headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}

for name, query in queries.items():
    try:
        url = 'https://www.bing.com/images/search?q=' + urllib.parse.quote(query) + '&FORM=HDRSC2'
        req = urllib.request.Request(url, headers=req_headers)
        with urllib.request.urlopen(req) as response:
            html = response.read().decode('utf-8')
            urls = re.findall(r'murl&quot;:&quot;(http[^&]+(?:jpg|png|jpeg))&quot;', html)
            if not urls:
                urls = re.findall(r'murl":"(http[^"]+(?:jpg|png|jpeg))"', html)
            
            if urls:
                img_url = urls[0]
                print(f"Found {img_url} for {name}")
                img_req = urllib.request.Request(img_url, headers=req_headers)
                with urllib.request.urlopen(img_req, timeout=10) as img_resp:
                    img_data = img_resp.read()
                    img = Image.open(BytesIO(img_data))
                    if img.mode in ('RGBA', 'P'):
                        img = img.convert('RGB')
                    
                    out_path = os.path.join(assets_dir, f'{name}.webp')
                    img.save(out_path, 'webp')
                    print(f'Saved {name}.webp')
            else:
                print(f"No image found for {name}")
    except Exception as e:
        print(f'Error on {name}: {e}')
