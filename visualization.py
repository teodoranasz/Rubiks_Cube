import matplotlib.pyplot as plt


def create_plot(ax,face,paint_parameters):
    colors = ['white', 'red', 'blue', 'yellow', 'orange', 'green']
    entries_of_face = [entry for entry in paint_parameters if entry['face'] == face]

    center_tile = plt.Rectangle((1, 1), 1, 1, facecolor=colors[face-1])
    ax.add_patch(center_tile)
    for entry in entries_of_face:
        square = plt.Rectangle(entry['coordinates'], 1, 1, facecolor=entry['color'], edgecolor='black', linewidth=1)
        ax.add_patch(square)

    ax.set_xlim(0, 3)
    ax.set_ylim(0, 3)
    ax.set_aspect('equal', 'box')  # equal aspect ratio
    ax.set_xticks([])
    ax.set_yticks([])

fig, axs = plt.subplots(2, 3, figsize=(12, 8))

def plot_cube(paint_parameters):
    create_plot(axs[0, 0], 1, paint_parameters) #(top)
    create_plot(axs[0, 1], 2, paint_parameters) #(front)
    create_plot(axs[0, 2], 3, paint_parameters) #(right)
    create_plot(axs[1, 0], 4, paint_parameters) #(bottom)
    create_plot(axs[1, 1], 5, paint_parameters) #(back)
    create_plot(axs[1, 2], 6, paint_parameters) #(left)

    # better spacing
    plt.tight_layout()

    plt.show()
