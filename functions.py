import clingo
import parse as P
import visualization as V

paint_parameters = []

### on_model functions applied to first found model
def create_onmodel(plttime=0, write_instance=False, to_print=[]):
    def on_model(model):

        # extract array of predicates that constitute model
        solution = [str(atom) for atom in model.symbols(shown=True)]

        # optional: output instance in instance.lp
        if write_instance:
            with open('instance.lp', 'w') as file:
                for predicate in solution:
                    if 'paint' in predicate and ','+str(plttime)+')' in predicate:
                        crop = len(str(plttime))+1
                        file.write(predicate[:-crop] + "0).\n")

        # optional: print predicates, e.g. rotateClockwise
        # need to "#show" them first!
        for predicate in solution:
            for printable in to_print:
                if printable in predicate:
                    print(predicate + ".")

        # specify which timestep to use for visualization; default=0
        for predicate in solution:
            # the comma before plttime is needed!! otherwise it finds '0' in 10th, 20th step etc.
            if 'paintCorner' in predicate and ','+str(plttime)+')' in predicate:
                entry = P.parse_paint_corner(predicate)
                paint_parameters.append(entry)
            elif 'paintMid' in predicate and ','+str(plttime)+')' in predicate:
                entry = P.parse_paint_mid(predicate)
                paint_parameters.append(entry)
    return on_model
#
# # used in generate_cube
# def extract_cube(model):
#     with open('instance.lp','w') as file:
#         # write predicates that constitute model to instance.lp
#         solution = [str(atom) for atom in model.symbols(shown=True)]
#         for predicate in solution:
#             if 'paint' in predicate:
#                 file.write(predicate + ".\n")
#
#     # specify which predicates to use for visualization: timestep 0
#     for predicate in solution:
#         if "paintCorner" in predicate and ',0)' in predicate:
#             entry = P.parse_paint_corner(predicate)
#             paint_parameters.append(entry)
#         elif "paintMid" in predicate and ',0)' in predicate:
#             entry = P.parse_paint_mid(predicate)
#             paint_parameters.append(entry)
#
# # used in diy_cube
# # creates time-specific diy_onmodel
# def time_spec_diy_onmodel(time):
#     def diy_onmodel(model):
#         # extract array of predicates that constitute model
#         solution = [str(atom) for atom in model.symbols(shown=True)]
#         # write predicates that constitute model to instance.lp
#         with open('instance.lp', 'w') as file:
#             solution = [str(atom) for atom in model.symbols(shown=True)]
#             for predicate in solution:
#                 if 'paint' in predicate:
#                     file.write(predicate + ".\n")
#
#         for predicate in solution:
#             if "paintCorner" in predicate and str(time)+')' in predicate:
#                 entry = P.parse_paint_corner(predicate)
#                 paint_parameters.append(entry)
#             elif "paintMid" in predicate and str(time)+')' in predicate:
#                 entry = P.parse_paint_mid(predicate)
#                 paint_parameters.append(entry)
#     return diy_onmodel


### running functions

# runs generator to output some instance, store in instance.lp
def generate_cube():
    control = clingo.Control()
    control.load('generator.lp')
    control.ground([("base", [])])
    control.solve(on_model=create_onmodel(write_instance=True))

    V.plot_cube(paint_parameters)

# generates instance with solution in =slvtime steps
def build_solvable_cube(slvtime):
    control = clingo.Control()
    with open('specifics.lp','w') as file:
        file.write('time(0..'+str(slvtime)+'). \n\n:- cubeFinished('+str(slvtime-1)+'). \n:- not cubeFinished('+str(slvtime)+').')
    control.load('generator.lp')
    control.load('cube_rules.lp')
    control.load('specifics.lp')
    control.ground([("base", [])])
    control.solve(on_model=create_onmodel(to_print=['rotateC', 'cubeF']))

    V.plot_cube(paint_parameters)

# helper: solve_instance solves instance.lp in <=slvtime steps
def create_solveinstance(slvtime,to_print=['rotateC','cubeF']):
    def solve_instance():
        with open('specifics.lp', 'w') as file:
            file.write('time(0..' + str(slvtime) + '). \n\n:- not cubeFinished('+ str(slvtime) + ').')
        control = clingo.Control()
        control.load('cube_rules.lp')
        control.load('specifics.lp')
        control.load('instance.lp')
        control.ground([("base", [])])
        control.solve(on_model=create_onmodel(to_print=to_print))

        V.plot_cube(paint_parameters)
    return solve_instance

# input array of pairs (face, 1/-1 for clockwise/counter)
# vernünftige rechenzeit bis timestep = 12
def diy_cube(moves):
    timestep = 0
    with open('diy.lp', 'a') as file:
        for face, orientation in moves:
            if orientation > 0:
                file.write('\nrotateClockwise(' + str(face) + ',' + str(timestep) + ').')
            else:
                file.write('\nrotateCounterClockwise(' + str(face) + ',' + str(timestep) + ').')
            timestep += (1 + 2*(orientation<0))

        file.write('\n\ntime(0..'+str(timestep)+').')

    control = clingo.Control()
    control.load('cube_rules.lp')
    control.load('diy.lp')
    control.ground([("base", [])])
    control.solve(on_model=create_onmodel(plttime=timestep,write_instance=True))

    with open('diy.lp', 'r') as file:
        content = file.readlines()
    with open('diy.lp', 'w') as file:
        file.writelines(content[:13])

    V.plot_cube(paint_parameters)


