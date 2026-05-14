import urllib.request
import urllib.parse
import os
from PIL import Image
from io import BytesIO

prompt = "A highly detailed, professional product photography studio shot of a Los Angeles Lakers black Mamba Mentality T-Shirt, floating slightly against a clean dark grey background, dramatic lighting, high end e-commerce style"
encoded_prompt = urllib.parse.quote(prompt)
url = f"https://image.pollinations.ai/prompt/{encoded_prompt}?width=1024&height=1024&nologo=true"

assets_dir = r'c:\nba_app\assets\store'

try:
    print(f"Downloading from {url}...")
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req) as response:
        img_data = response.read()
        img = Image.open(BytesIO(img_data)).convert('RGB')
        
        out_path = os.path.join(assets_dir, 'lakers_tshirt.webp')
        img.save(out_path, 'webp', quality=95)
        print("Successfully generated and saved lakers_tshirt via Pollinations AI")
except Exception as e:
    print(f"Error: {e}")
