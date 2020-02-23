# Lecture 3: Graph-theoretic Models

## Example Lecture3-graph-theoretic-models.playground

This example is just a strauight Python -> Swift translation of the `DFS` and `BFS` algorithms for finding the shortest path betweend two nodes. 

## ExampleLecture3-graph-theoretic-models-w-weights.playground

In this example I did my best to adapt the `DFS` algorithm so that it would take into account `weight` values attached to each `Edge` between 2 `Node` instances.

After many failed attempts the best course of action I could find was to modify `DiGraph` so that it could calculate the weight of a path of `Node` by looking up the known `Edge` instances between them. 

Finally I also added a way to cache the result of the total path weights as an optimization.

## Example lectureGraphs.py

This python script was modfied to add the alteration fo the `DFS` algorithm so that it would take `weight` into account.