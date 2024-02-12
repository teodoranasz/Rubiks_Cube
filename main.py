import clingo
import visualization as V
import parse as P
import functions as F

#moves = [(1,-1),(5,1)]
#F.diy_cube(moves)
solver = F.create_solveinstance(4)
solver()