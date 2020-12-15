# Phylotranscriptomics

- Author: Chao Tong
- Date: Jan-1-2020


#### Gene Orthology

extract OGG from hamsearch_<species>.out files


1. 将OGG主文件夹下的所有hamstrsearch_{species_initial, Mpha}_{family, eg. hym}_out的文件复制到一个新的文件夹中，任意命名
```
cp {PATH}/hamstrsearch_* ./{your PATH}
```

2. 检查out文件，每行均是以EOG开头，|1|或者一个或者多个|0|结尾。
- 此时需要将所有的out文件整合成一个outfile,后需要将重复的带有|0|的冗余行过滤，保留唯一解|1|

```
cat *.out > outfile
cat outfile | grep -v "|0|" outfile > outfile_1
```

3. 检查新的outfile_1文件，删除或者替换冗余的符号
- 由于有些基因组序列中带有|lcl|等多余内容，需要删除
```
sed -i 's/|lcl|/|/' outfile_1
```

4. 再次检查outfile_1文件内容，先创建新的文件夹1_cds，后进行文件裂解（split）
```
mkdir 1_cds
perl each-group-CDS.pl outfile_1 1_cds #裂解outfile_1文件按照物种（species）排序成为多了单独的文件，保存至1_cds文件夹中
```

5. 进入1_cds文件夹中，检查EOG开头文件内容，统计物种数目

```
cd 1_cds
grep ">" -c *.fas >> ./count_ogg.txt #将统计结果进行提取，并保存到count_ogg.txt文件中
```
6. 提取文件，进行后续的比对
- 需要过滤出包含序列数目和物种数目一致的EOG文件，进行后续比比对

7.运用filter_sample.py的python的脚本，后得到core_ogg_list的结果文件
```
python filter_sample.py
```

8. 创建core_ortholog的文件夹
```
mkdir core_ortholog
```
9. 运行以下命令
```
cat core_ogg_list | awk '{print$1}' | xargs -I '{}' mv {} core_ortholog/
```
