import os
import glob
from PIL import Image

brain_dir = r'C:\Users\longo\.gemini\antigravity\brain\cec948b8-3bbd-4b71-a811-580ebde81268'
assets_dir = r'c:\nba_app\assets\store'

os.makedirs(assets_dir, exist_ok=True)

for p in glob.glob(os.path.join(brain_dir, '*.png')):
    basename = os.path.basename(p)
    parts = basename.split('_')
    # Remove the timestamp (the last part before .png)
    base = '_'.join(parts[:-1])
    if not base:
        base = basename.replace('.png', '')
        
    out_path = os.path.join(assets_dir, base + '.webp')
    
    try:
        img = Image.open(p)
        img.save(out_path, 'webp')
        print(f'Converted {basename} to {base}.webp')
    except Exception as e:
        print(f'Error converting {basename}: {e}')
