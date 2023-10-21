taxa = [ ('Myotis lucifugus','Chiroptera'),
         ('Gerbillus henleyi','Rodentia',),
         ('Peromyscus crinitus', 'Rodentia'),
         ('Mus domesticus', 'Rodentia'),
         ('Cleithrionomys rutilus', 'Rodentia'),
         ('Microgale dobsoni', 'Afrosoricida'),
         ('Microgale talazaci', 'Afrosoricida'),
         ('Lyacon pictus', 'Carnivora'),
         ('Arctocephalus gazella', 'Carnivora'),
         ('Canis lupus', 'Carnivora'),
        ]

# Write a python script to populate a dictionary called taxa_dic derived from
# taxa so that it maps order names to sets of taxa and prints it to screen.
# 
# An example output is:
#  
# 'Chiroptera' : set(['Myotis lucifugus']) ... etc. 
# OR, 
# 'Chiroptera': {'Myotis  lucifugus'} ... etc

#### Your solution here #### 

# Now write a list comprehension that does the same (including the printing after the dictionary has been created)  
 
#### Your solution here #### 

taxa_dic = {}

for t in taxa:
    species, order_name = t
    if order_name not in taxa_dic:
        taxa_dic[order_name] = set()
    taxa_dic[order_name].add(species)

print(taxa_dic)

taxa_dic = {order_name: {species for species, ord in taxa if ord == order_name} for _, order_name in taxa}
print(taxa_dic)
