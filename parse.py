def parse_paint_mid(predicate):

    # predicates of the form "paintMid(position,face,color,timestep)"
    parts = predicate.split(',')
    position = parts[0][-1]  # t, b, l, or r
    face = int(parts[1]) # face in 1..6
    color_int = int(parts[2])  # color in 1..6
    timestep = int(parts[-1][:-1]) # timestep in 0..60 can have multiple digits

    color_mapping = { 1: 'white',
                      2: 'red',
                      3: 'blue',
                      4: 'yellow',
                      5: 'orange',
                      6: 'green'  }
    color = color_mapping.get(color_int, 'unknown')

    if position == 't':
        x = 1
        y = 2
    elif position == 'b':
        x = 1
        y = 0
    elif position == 'l':
        x = 0
        y = 1
    elif position == 'r':
        x = 2
        y = 1
    else:
        raise ValueError("invalid position")

    result = { 'coordinates': (x, y),
               'face': face,
               'color': color,
               'timestep': timestep }

    return result

def parse_paint_corner(predicate):

    # predicates of the form "paintCorner(row,column,face,color,timestep)"
    parts = predicate.split(',')
    row = parts[0][-1]  # t or b
    col = parts[1]      # l or r
    face = int(parts[2])  # face in 1..6
    color_int = int(parts[3]) # color in 1..6
    timestep = int(parts[-1][:-1])  # time in 0..60 can have multiple digits

    color_mapping = { 1: 'white',
                      2: 'red',
                      3: 'blue',
                      4: 'yellow',
                      5: 'orange',
                      6: 'green' }
    color = color_mapping.get(color_int, 'unknown')

    if row == 't':
        y = 2
    elif row == 'b':
        y = 0
    else:
        raise ValueError("invalid row")

    if col == 'l':
        x = 0
    elif col == 'r':
        x = 2
    else:
        raise ValueError("invalid column")

    result = { 'coordinates': (x, y),
               'face': face,
               'color': color,
               'timestep': timestep  }

    return result