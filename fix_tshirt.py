from duckduckgo_search import DDGS
import urllib.request
import os
from io import BytesIO
from PIL import Image

query = 'Nike Los Angeles Lakers Mamba Mentality T-Shirt black front'
assets_dir = r'c:\nba_app\assets\store'
req_headers = {'User-Agent': 'Mozilla/5.0'}

with DDGS() as ddgs:
    results = list(ddgs.images(query, max_results=10))
    for r in results:
        url = r['image']
        print(f"Trying {url}...")
        try:
            req = urllib.request.Request(url, headers=req_headers)
            with urllib.request.urlopen(req, timeout=10) as response:
                img_data = response.read()
                img = Image.open(BytesIO(img_data)).convert('RGBA')
                
                target_size = (1024, 1024)
                bg_color = (40, 40, 40)
                
                img.thumbnail((800, 800), Image.Resampling.LANCZOS)
                
                bg = Image.new('RGB', target_size, bg_color)
                offset = ((target_size[0] - img.width) // 2, (target_size[1] - img.height) // 2)
                bg.paste(img, offset, img)
                
                out_path = os.path.join(assets_dir, 'lakers_tshirt.webp')
                bg.save(out_path, 'webp', quality=90)
                print(f"Success!")
                break
        except Exception as e:
            print(f"Error: {e}")
