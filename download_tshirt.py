import urllib.request
import os
from io import BytesIO
from PIL import Image

url = 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?q=80&w=800'
assets_dir = r'c:\nba_app\assets\store'

try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        img_data = response.read()
        img = Image.open(BytesIO(img_data)).convert('RGBA')
        
        target_size = (1024, 1024)
        bg_color = (40, 40, 40)
        
        # Calculate aspect ratio
        img.thumbnail((800, 800), Image.Resampling.LANCZOS)
        
        bg = Image.new('RGB', target_size, bg_color)
        
        # Paste the image in the center
        offset = ((target_size[0] - img.width) // 2, (target_size[1] - img.height) // 2)
        
        # We don't use mask because the unsplash image is a full photo with a background
        bg.paste(img.convert('RGB'), offset)
        
        out_path = os.path.join(assets_dir, 'lakers_tshirt.webp')
        bg.save(out_path, 'webp', quality=95)
        print("Successfully downloaded and fixed lakers_tshirt")
except Exception as e:
    print(f"Error: {e}")
