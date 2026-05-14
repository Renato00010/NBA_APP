from duckduckgo_search import DDGS
import urllib.request
import os
from io import BytesIO
from PIL import Image

queries = {
    'lebron_shoes': 'Nike LeBron 21 basketball shoes white background -site:pinterest.com',
    'bulls_jersey': 'Mitchell and Ness Chicago Bulls Michael Jordan 1998 authentic jersey front white background -site:pinterest.com',
    'nba_backpack': 'Nike Hoops Elite Pro Backpack NBA black white background -site:pinterest.com',
    'lakers_tshirt': 'Nike Los Angeles Lakers Mamba Mentality T-Shirt black front white background -site:pinterest.com'
}

assets_dir = r'c:\nba_app\assets\store'
req_headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}

with DDGS() as ddgs:
    for name, query in queries.items():
        print(f"Searching for {name}...")
        results = list(ddgs.images(query, max_results=5))
        
        saved = False
        for r in results:
            if saved: break
            url = r['image']
            print(f"Trying URL for {name}: {url}")
            try:
                req = urllib.request.Request(url, headers=req_headers)
                with urllib.request.urlopen(req, timeout=10) as response:
                    img_data = response.read()
                    img = Image.open(BytesIO(img_data))
                    if img.mode in ('RGBA', 'P'):
                        bg = Image.new('RGB', img.size, (255, 255, 255))
                        if img.mode == 'RGBA':
                            bg.paste(img, mask=img.split()[3])
                        else:
                            bg.paste(img)
                        img = bg
                    elif img.mode != 'RGB':
                        img = img.convert('RGB')
                        
                    out_path = os.path.join(assets_dir, f'{name}.webp')
                    img.save(out_path, 'webp', quality=90)
                    print(f'Successfully downloaded and saved {name}.webp')
                    saved = True
            except Exception as e:
                print(f"Failed {url}: {e}")
