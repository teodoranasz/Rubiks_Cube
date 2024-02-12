import clingo
import visualization as V
import parse as P
import functions as F

moves = [(1,1),(3,-1),(2,-1),(4,-1),(5,1),(1,1)]
F.diy_cube(moves)
#solver = F.create_solveinstance(12)
#solver()