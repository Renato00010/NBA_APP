import os
import urllib.request
from PIL import Image
from io import BytesIO

assets_dir = r'c:\nba_app\assets\store'
os.makedirs(assets_dir, exist_ok=True)

images = {
    'lebron_shoes': 'https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?q=80&w=800&auto=format&fit=crop',
    'bulls_jersey': 'https://images.unsplash.com/photo-1515523110800-9415d13b84a8?q=80&w=800&auto=format&fit=crop',
    'curry_shoes': 'https://images.unsplash.com/photo-1556906781-9a412961c28c?q=80&w=800&auto=format&fit=crop',
    'wilson_ball': 'https://images.unsplash.com/photo-1543326727-cf6c39e8f84c?q=80&w=800&auto=format&fit=crop',
    'nba_backpack': 'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?q=80&w=800&auto=format&fit=crop',
    'lakers_tshirt': 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=800&auto=format&fit=crop'
}

req_headers = {'User-Agent': 'Mozilla/5.0'}

for name, url in images.items():
    try:
        print(f'Downloading {name}...')
        req = urllib.request.Request(url, headers=req_headers)
        with urllib.request.urlopen(req) as response:
            img_data = response.read()
            img = Image.open(BytesIO(img_data))
            
            # Ensure image is in RGB mode before saving as WebP
            if img.mode in ('RGBA', 'P'):
                img = img.convert('RGB')
                
            out_path = os.path.join(assets_dir, f'{name}.webp')
            img.save(out_path, 'webp')
            print(f'Successfully saved {out_path}')
    except Exception as e:
        print(f'Error processing {name}: {e}')
