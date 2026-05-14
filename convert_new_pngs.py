import os
import glob
from PIL import Image

brain_dir = r'C:\Users\longo\.gemini\antigravity\brain\cec948b8-3bbd-4b71-a811-580ebde81268'
assets_dir = r'c:\nba_app\assets\store'

for p in glob.glob(os.path.join(brain_dir, '*.png')):
    basename = os.path.basename(p)
    if 'test' in basename or 'bulls' in basename or 'curry' in basename or 'wilson' in basename or 'backpack' in basename:
        parts = basename.split('_')
        # Remove timestamp
        base = '_'.join(parts[:-1])
        if base == 'lebron_shoes_test':
            base = 'lebron_shoes'
            
        out_path = os.path.join(assets_dir, base + '.webp')
        
        try:
            img = Image.open(p)
            img.save(out_path, 'webp')
            print(f'Converted {basename} to {base}.webp')
        except Exception as e:
            print(f'Error converting {basename}: {e}')
