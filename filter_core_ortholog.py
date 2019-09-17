import re

inputfile = "count_ogg.txt"
outputfile = "core_ogg_list"

out = open(outputfile,'w')
out.close()

with open(inputfile) as infile:
        for line in infile:
                count = re.split(':',line)[1]
                if int(count) > 24:
                        with open(outputfile,'a') as out:
                                out.write(re.split(':',line)[0]+'\t'+str(count))
