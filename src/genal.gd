extends Node

# =============================
# /---------------------------\
# |       Ron0Studios         |
# |genetic algorithm framework|
# \---------------------------/
# =============================

# Tips for using this library:
# - heed the warnings provided by the code! They're there for a reason!
# - editing internal variables is fine, if you know what you're doing!
# - global (export) variables can be changed, but expect untested results
#   if changing them during the runtime of the algorithm
# - have fun! make sure to report anything on github!

# All you have to do is define the gene, and calculate fitness!

# |================|
# |GLOBAL VARIABLES|
# |================|

# export variables
var GEN_SIZE : int = 20 
var MUTATE_CHANCE : float = 0.05


# internal variables
var _generations : Array = []
var _current_fitness : Array = []
var _gene_defined = false
var _genome_template : Array = []
var _genome_member_count : int = 1

# |==============|
# |MAIN FUNCTIONS|
# |==============|

# This function must be run before doing anything else - it defines (and validates) the genome
# A genome is described as follows:
#     [[Gene1],[Gene2],[Gene3],[Gene4]]
# In each gene, you MUST first specify the datatype of each member of the gene.
# You MUST also specify how many members each gene will have in the second argument!
# Depending on the type you choose, you can also specify other features, such as a range.
# An example of a genome would be:
# [[TYPE_INT,0,5],[TYPE_STRING], [TYPE_REAL,0,,0.9]]
func set_genome(data : Array, member_count : int):
	
	var temp_genome = data.duplicate() # temprary genome
	
	for i in temp_genome:
		match i[0]:
			TYPE_INT:
				if len(i) > 3 or len(i) == 2:
					push_error("Invalid argument set provided for TYPE_INT")
				if len(i) == 1:
					i[0].append_array([0,10])
					push_warning("WARNING: using default ranges for gene")
				if i[1] > i[2]:
					push_warning("Range is negative!")
			TYPE_STRING:
				if len(i) > 2:
					push_error("Too many arguments provided for TYPE_STRING")
				if len(i) == 1:
					i[0].append(5)
					push_warning("WARNING: using default ranges for gene")
			TYPE_BOOL:
				if len(i) > 1:
					printerr("Too many arguments provided for TYPE_BOOL")
			TYPE_REAL:
				if len(i) > 3 or len(i) == 2:
					push_error("Invalid argument set provided for TYPE_REAL")
				if len(i) == 1:
					i[0].append_array([0.0,10.0])
					push_warning("WARNING: using default ranges for gene")
				if i[1] > i[2]:
					push_warning("Range is negative!")
			_:
				printerr("This type is not defined by Genal.gd")
	
	_genome_member_count = member_count
	_genome_template = temp_genome
	_gene_defined = true
	pass

# generates a random generation, based on GEN_SIZE and appends it to
# _generations, hence counting as initialization for the algorithm
func random_gen(): 
	if not _gene_defined:
		push_error("Please define a gene structure before starting!")
	
	var output = [] # finished generation to be appended to _generations
	var randomizer = RandomNumberGenerator.new()
	randomizer.randomize()
	
	for i in range(GEN_SIZE):
		var individual = []
		for gene in _genome_template:
			individual.append([])
			for x in range(_genome_member_count):
				match gene[0]:
					TYPE_INT:
						individual[-1].append(randomizer.randi_range(gene[1],gene[2]))
					TYPE_STRING:
						var temp_string = ""
						for _tmp in range(gene[1]):
							temp_string += char(65+randomizer.randi_range(0,25)) # only capital letters
						individual[-1].append(temp_string)
					TYPE_BOOL:
						individual[-1].append(randomizer.randi_range(0,1))
					TYPE_REAL:
						individual[-1].append(randomizer.randf_range(gene[1],gene[2]))
		output.append(individual)
	_generations.append(output)

func get_latest_generation():
	return _generations[-1]
	
func update_fitness(fitness):
	_current_fitness = fitness
	pass

func step_algorithm():
	pass


	

# |===================|
# |SELECTION FUNCTIONS|
# |===================|

func roulette_selection():
	pass

func random_selection():
	pass

func elitism_selection():
	pass

func tournament_selection():
	pass


#
#var generations = []
#var genfitness = []
#var gensize = 20 # size per generation
#var fitness_id = 0
#var mutate_chance = 0.05
#var max_life = 15
#
#
#var n_mutations = 0
#
#func randomgen():# generates a completely random first generation
#	var outgen = []
#	var randomizer = RandomNumberGenerator.new() # to create new seed
#
#	for _i in range(gensize):
#		var gene = [[],[],[],[],[]] # for one organism
#		for _j in range(8):
#			gene[0].append(randomizer.randf_range(-1,1)) # x coord
#			gene[1].append(randomizer.randf_range(-1,1)) # y coord
#			gene[2].append(round(randf())) # wheelenabled
#			gene[3].append(randf()) # wheel radius (close to 0 means no wheel)
#			gene[4].append((randf()+0.01)*2) # wheel weight (0-2x weight) (close to 0 means no weight)
#		outgen.append(gene)
#
#	return outgen
#
## selects 2 from set
#func roulette_selection(set):
#	var selection = []
#	var fitset = genfitness[-1].duplicate() # fitness of the last generation
#
#
#	var wheel = 0
#	var minval = 999999999999
#	for i in fitset:
#		if i < minval:
#			minval = i
#		wheel += abs(i)
#
#	for i in range(2):
#		var pick = rand_range(minval,minval+wheel)
#		var current = minval
#		for j in gensize:
#			current += abs(fitset[j])
#			if current >= pick:
#				selection.append(set[j])
#				break
#
#
#	return selection
#
#func rand_selection(set, size=2):
#	var selection = []
#	var rng = RandomNumberGenerator.new()
#	rng.randomize()
#	for _i in range(size):
#		selection.append(set[rng.randi_range(0,gensize-1)])
#	return selection
#
#func single_point_crossover(chrom1, chrom2):
#	var rng = RandomNumberGenerator.new()
#	var crosspoint = rng.randi_range(1,7)
#
#	var new1 = [[],[],[],[],[]]
#	var new2 = [[],[],[],[],[]]
#
#	for i in range(len(chrom1)):
#		for j in range(8):
#			if i % 2 == 0:
#				new1[i].append(chrom1[i][j])
#				new2[i].append(chrom1[i][j])
#			else:
#				new1[i].append(chrom2[i][j])
#				new2[i].append(chrom2[i][j])
#
#	return [new1,new2]
#
#	for i in range(len(chrom1)): 
#		# chromosome 1
#		var keep = chrom1[i].slice(0,crosspoint-1)
#		var add = chrom2[i].slice(crosspoint,7)
#		# chromosome 2
#		var keep2 = chrom2[i].slice(0,crosspoint-1)
#		var add2 = chrom1[i].slice(crosspoint,7)
#
#		# crossover
#		chrom1[i] = keep + add
#		chrom2[i] = keep2 + add2
#	return [chrom1,chrom2]
#
#
## selects 2 from set
#func elitism_selection(set : Array, amt : int = 2):
#	var selection = []
#
#	for i in range(len(set)):
#		set[i].append(genfitness[-1][i])
#
#
#	set.sort_custom(self, "fitcomp")
#
#
#	for i in range(amt):
#		selection.append(set[i])
#
#	# removes temporary fitness addon
#	for i in set:
#		for j in i:
#			if typeof(j) != TYPE_ARRAY:
#				i.erase(j)
#	return selection
#
## custom comparitor for sorting by fitness
#func fitcomp(a,b):
#	return a[-1] > b[-1]
#
#
## selects 2 from set, tsize = tournament size
#func tournament_selection(set, tsize):
#	var selection = []
#	for i in range(len(set)):
#		set[i].append(genfitness[-1][i])
#
#	set.sort_custom(self, "fitcomp")
#	for _i in range(2):
#		var tournament = []
#		for _j in range(tsize):
#			tournament.append(set[rand_range(0,gensize-1)])
#
#		tournament.sort_custom(self,"fitcomp")
#		selection.append(tournament[0])
#
#	# removes temporary fitness addon
#	for i in set:
#		for j in i:
#			if typeof(j) != TYPE_ARRAY:
#				i.erase(j)
#	return selection
#
#func mutate(gene):
#	var set = gene.duplicate()
#	var n_mut = 0
#
#	# x coord mutation
#	for i in range(len(set[0])):
#		if randf() <= mutate_chance:
#			set[0][i] = rand_range(-1,1)
#			n_mut += 1
#
#	# y coord mutation
#	for i in range(len(set[1])):
#		if randf() <= mutate_chance:
#			set[1][i] = rand_range(-1,1)
#			n_mut += 1
#
#	# wheel enabled
#	for i in range(len(set[2])):
#		if randf() <= mutate_chance:
#			set[2][i] = round(randf())
#			n_mut += 1
#
#	# wheel radius
#	for i in range(len(set[3])):
#		if randf() <= mutate_chance:
#			set[3][i] = randf()*1.5
#			n_mut += 1
#
#	# wheel weight
#	for i in range(len(set[4])):
#		if randf() <= mutate_chance:
#			set[4][i] = (randf()+0.01)*3
#			n_mut += 1
#
#	n_mutations += n_mut
#	return set
#
#func nextgen(inp):
#	var prevgen = inp
#	var gen = []
#
#
#	# elitism pick
#	var best2 = elitism_selection(prevgen)
#	gen.append_array(best2)
#	while len(gen) < gensize:
#		#mutate_chance /= sqrt(len(generations)+1)
#
#		if len(gen) == 4: # DEBUG breakpoint for bug
#			pass
#		#var selection = elitism_selection(prevgen)
#		#var selection = tournament_selection(prevgen,4)
#		var selection = roulette_selection(prevgen)
#		var crossover = single_point_crossover(selection[0].duplicate(),selection[1].duplicate())
#		var newchildA = crossover[0]
#		var newchildB = crossover[1]
#
#		newchildA = mutate(newchildA)
#		newchildB = mutate(newchildB)
#
#		gen.append(newchildA)
#		gen.append(newchildB)
#
#
#	# DEBUG
#	# print average fitness
#	var total_fit = 0
#	var max_fit = -99999999
#	for i in genfitness[-1]:
#		if i > max_fit:
#			max_fit = i
#		total_fit += i
#	#print("Total Mutations: ", n_mutations)
#	#print("Total Fitness: ", total_fit/gensize, "\n----------")
#	print(stepify(max_fit,0.01),"\t\t\t",stepify(total_fit/gensize,0.01))
#
#	n_mutations = 0
#	# set the next generation
#	generations.append(gen)
#
#
## distance: the total distance travelled from start
## wheelsum: sum of sizes of all wheels (we want to minimize)
#func fitness(distance, wheelsum, bodyvolume, weight):
#
#
#	match fitness_id:
#		0: # balanced
#			return pow(distance,2) - pow(wheelsum*30,3) 
#		1: # volume
#			return -bodyvolume
#		2: # wheels
#			return wheelsum
#		3: # distance
#			return distance
#		4: # weight
#			return weight
#
#
#func _enter_tree():
#	generations.append(randomgen())
