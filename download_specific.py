import urllib.request
import os
from io import BytesIO
from PIL import Image

urls = {
    'lebron_shoes': 'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/a59a93ce-9494-4328-8767-4632bbde1a24/lebron-xxi-conchiolin-basketball-shoes-31W0gK.png',
    'bulls_jersey': 'https://www.mitchellandness.com/media/catalog/product/A/J/AJY4CP19009-CBUREDK98MJO_1.jpg',
    'curry_shoes': 'https://underarmour.scene7.com/is/image/Underarmour/3026615-100_DEFAULT?rp=standard-0pad|pdpMainDesktop&scl=1&fmt=jpg&qlt=85&resMode=sharp2&cache=on,on&bgc=F0F0F0&wid=566&hei=708&size=566,708',
    'wilson_ball': 'https://www.wilson.com/en-us/media/catalog/product/W/T/WTB7500XB__0_NBA_Official_Game_Ball.png',
    'nba_backpack': 'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/5dd1bf7f-44e2-45e0-b605-e83ee91c53cd/hoops-elite-pro-basketball-backpack-M3mP9J.png',
    'lakers_tshirt': 'https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/60f76904-44cd-4e8c-8f92-ec6d2c4161f5/los-angeles-lakers-mens-nba-t-shirt-L1b41x.png'
}

assets_dir = r'c:\nba_app\assets\store'
req_headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}

for name, url in urls.items():
    try:
        req = urllib.request.Request(url, headers=req_headers)
        with urllib.request.urlopen(req, timeout=10) as response:
            img_data = response.read()
            img = Image.open(BytesIO(img_data))
            if img.mode in ('RGBA', 'P'):
                # Handle transparency by pasting onto white background
                bg = Image.new('RGB', img.size, (255, 255, 255))
                if img.mode == 'RGBA':
                    bg.paste(img, mask=img.split()[3])
                else:
                    bg.paste(img)
                img = bg
            elif img.mode != 'RGB':
                img = img.convert('RGB')
                
            out_path = os.path.join(assets_dir, f'{name}.webp')
            img.save(out_path, 'webp')
            print(f'Successfully downloaded and saved {name}.webp')
    except Exception as e:
        print(f'Failed for {name}: {e}')
