# matlab Path Smoother

This is a matlab reimplementation of the paper `Planning Dynamically Feasible Trajectories for Quadrotors Using Safe Flight Corridors in 3-D Complex Environment` by Sikang Liu et al on July 2017.

paper is provided in this repository.

## Astar package

The `Astar` package provides an astar path finder.

Change the input source of the map or manually type the map out is possible.

1. read map from file:

    Change the input source file. The file should be a 2d img of the map. I assume darker part is obstacle.

2. manually type the map:

    like line 17 to 29. Write your own map matrix and give the value to `map.cellStatus`.

    legend: 0 - blank, 1 - obstacle

    You can simply uncomment the given `map.cellStatus` sample and substitute my sample map with yours.

Then you need to manually set the start point and the end point. The point is a image coordinate: [row, column].

Finally, it is going to find path and store the path in the `path` variable in the format of cell array.

Sample result:
![astar img](/pic/astarResult.jpg)

red - searched block; blud - final path.
