

pre_format = '''
# Rime dictionary
# encoding: utf-8
---
name: xkjd6_{n_th}
version: "2023.06.13"
sort: original #字典初始排序，可選original或by_weight
use_preset_vocabulary: false
...
'''


with open("xkjd6.dict.yaml","r") as in_file:
    cnt = 0
    n_th = 0
    end = False
    while not end:
        n_th += 1
        with open("xkjd6_{}.dict.yaml".format(n_th),"w") as out_file:
            out_file.write(pre_format.format(n_th = n_th))
            for cnt in range(200000):
                line = in_file.readline()
                if not line:
                    end = True
                    break
                cnt += 1
                out_file.write(line)
            print("  - xkjd_dicts/xkjd6_{n_th}".format(n_th=n_th))
