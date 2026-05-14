from PIL import Image, ImageOps
import os

path = r'c:\nba_app\assets\store\lakers_tshirt.webp'

try:
    img = Image.open(path).convert('RGB')
    
    # Target size
    target_size = (1024, 1024)
    bg_color = (30, 30, 30) # Dark grey background
    
    # Calculate aspect ratio
    img.thumbnail((800, 800), Image.Resampling.LANCZOS)
    
    bg = Image.new('RGB', target_size, bg_color)
    offset = ((target_size[0] - img.width) // 2, (target_size[1] - img.height) // 2)
    
    bg.paste(img, offset)
    bg.save(path, 'webp', quality=90)
    print("Successfully padded lakers_tshirt")
except Exception as e:
    print(f"Failed to pad: {e}")
