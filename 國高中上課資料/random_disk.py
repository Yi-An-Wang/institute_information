import math
import matplotlib.pyplot as plt
from matplotlib.patches import Wedge, FancyArrow, Circle
import numpy as np

def arrow_omega(current_omega: float) -> float:
    return current_omega - 2*math.pi/10 * np.random.random()

def initial_omega() -> float:
    return 7*math.pi + 3*math.pi * np.random.random()

def initial_state(length: float) -> list[float]:
    angle = 2*math.pi * np.random.random()
    return [length*math.cos(angle), length*math.sin(angle), initial_omega()]

def draw_disk(ax) -> None:
    colors = {0: "#ff0000", 1: "#ff8000", 2: "#ffff00", 3: "#00ff00", 4: "#00ffff", 5: "#0000ff", 6: "#8000ff"}
    choices = 42
    sectors = [None]*choices
    r = 50
    for ii in range(choices):
        sectors[ii] = Wedge([0,0],r, 360/choices*ii, 360/choices*(ii+1), width=40, facecolor=colors[int(ii%7)])
        ax.add_patch(sectors[ii])
        ax.text((r+6)*math.cos(2*math.pi/choices*(ii+0.5))-1.5,(r+6)*math.sin(2*math.pi/choices*(ii+0.5))-1.5,f"{ii+1}")
    ax.add_patch(Circle([0,0], 10, facecolor="black"))

def move_arrow(arrow: FancyArrow, state: list[float], dt) -> list[float]:
    omega = arrow_omega(state[2])
    theta = omega * dt
    rotate_M = np.array([[math.cos(theta), -math.sin(theta)], [math.sin(theta), math.cos(theta)]])
    new_xy = rotate_M @ np.array([[state[0]], [state[1]]])
    new_state = [new_xy[0,0], new_xy[1,0], omega]
    arrow.set_data(dx=new_state[0], dy=new_state[1])
    return new_state

def pointout(state: list[float], Ppoint: Circle):
    pose = np.array([[state[0]], [state[1]]])
    nothing_angle = np.linspace(0, 2*np.pi, 43)
    angles = (nothing_angle[0:42] + nothing_angle[1:43])/2
    r = 56
    x_list = r * np.cos(angles)
    y_list = r * np.sin(angles)
    points = np.vstack((x_list, y_list))
    point_center = points[:,0:1]
    for ii in range(42):
        if np.linalg.norm(pose - point_center) > np.linalg.norm(pose - points[:,ii:ii+1]):
            point_center = points[:,ii:ii+1]
    Ppoint.set_center(point_center.flatten())
    print(point_center)

def main():
    fig = plt.figure()
    ax = fig.add_subplot(111)
    ax.set_xlim(-60,60)
    ax.set_ylim(-60,60)
    ax.set_aspect("equal")
    draw_disk(ax)
    state = initial_state(40)
    arrow = FancyArrow(0,0, state[0], state[1], width=2, facecolor="white")
    ax.add_patch(arrow)
    cent = Circle([0,0], 6, facecolor="red")
    ax.add_patch(cent)
    bingo = Circle([0, 0], 4, facecolor="red", alpha=0.4)
    ax.add_patch(bingo)
    plt.pause(1)
    dt = 0.01
    plt.ion()
    while(state[2] >= 0):
        state = move_arrow(arrow, state, dt)
        plt.pause(dt)

    pointout(state, bingo)

    plt.ioff()
    plt.show()

if __name__ == "__main__":
    main()