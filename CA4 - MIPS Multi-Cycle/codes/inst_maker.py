def decimalToBinary(n):
    return "{0:012b}".format(int(n))
def hexaDecimal(n):
    return hex(n).split('x')[-1]

load='0000'
C='1000'
sub='000001000'
And='000010000'
branchz='0100'
moveTo='000000001'
moveFrom='000000010'
store='0001'
andi='1110'
addi='1100'


file1 = open("memory.mem","w")
L = []
counter=0
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_110_000000001'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1100_100000000000'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_000_000000100'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_000_000000100'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_000_000000100'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_000_000000100'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_010_000000001'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('0000_001111101000'+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append('1000_001_000000001'+'\n')
counter+=1


addrees=1001
for i in range(0,19) :
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(load+'_'+decimalToBinary(addrees)+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(C+'_'+'001'+'_'+sub+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(C+'_'+'010'+'_'+And+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(branchz+'_'+'010'+'_'+"{0:09b}".format(counter+6)+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(load+'_'+decimalToBinary(addrees)+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(C+'_'+'001'+'_'+moveTo+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(andi+'_'+decimalToBinary(0)+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(addi+'_'+decimalToBinary(i+1)+'\n')
    counter+=1
    L.append('@'+hexaDecimal(counter)+'\n')
    L.append(C+'_'+'110'+'_'+moveTo+'\n')
    counter+=1
    addrees+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append(C+'_'+'001'+'_'+moveFrom+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append(store+'_'+decimalToBinary(2000)+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append(C+'_'+'110'+'_'+moveFrom+'\n')
counter+=1
L.append('@'+hexaDecimal(counter)+'\n')
L.append(store+'_'+decimalToBinary(2001)+'\n')
counter+=1


addrees=1000
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(0)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(1)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(2)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(3)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(4)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(5)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(6)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(7)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(8)+'\n')
counter+=1
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(9)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(10)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(11)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(9291)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(6291)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(8206)+'\n')
addrees+=1

L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(15)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(16)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(17)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(18)+'\n')
addrees+=1
L.append('@'+hexaDecimal(addrees)+'\n')
L.append("{0:016b}".format(19)+'\n')
addrees+=1



# \n is placed to indicate EOL (End of Line)
file1.writelines(L)
print('end\n')
file1.close()