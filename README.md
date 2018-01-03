# List predicates #

Practicing PROLOG by implementing some list predicates.


### Use of backtracking ###

Some predicates are implemented to allow some unusual (depending on your programming background !) calls.

For instance checking for a given value to be in a list, we would use the predicate `list_member` as follow : `list_member([1,2,3,4,5], 5).`
But the same predicate could be used as `list_member([1,2,3,4,5], X).` to iterate over all values from the list and binding them to X through backtracking.

```prolog
?- list_member([1,2,3,4,5], X).
X = 1 ;
X = 2 ;
X = 3 ;
X = 4 ;
X = 5 ;
false.
```

Another example is `list_append` that can be use the following way `list_append([1,2,3], Ys, [1,2,3,a,b,c]).` to solve for `Ys`.

```prolog
?- list_append([1,2,3], Ys, [1,2,3,a,b,c]).
Ys = [a, b, c].
```

The same kind of behaviour applies to predicate like zip, unzip, etc.


### Predicates implemented ###

Non-exhaustive list of the predicates implemented.

```prolog
% Inserting/deleteing one element in/from a list
list_insert(Xs, X, Result).
list_delete_one(Xs, X, Result).

% Return a list containing only distinct values
list_unique(Xs, UniqueXs).

% Zip / Unzip
list_zip(Xs, Ys, XYs).
list_unzip(XYs, Xs, Ys).
list_zip_with_index(Xs, N, Zipped).

% Taking/Dropping N first elements from/of a list
list_take(Xs, N, R).
list_drop(Xs, N, R).

% Cartesian product of 2 lists
list_cp(Xs, Ys, R).

% Merge sort
merge_sort(Xs, Sorted).
```
