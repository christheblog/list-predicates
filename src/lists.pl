% Length of a list
list_length([],0).
list_length([_|T],N) :-
	list_length(T,N1),
	N is N1+1.

% Checks if a list is empty
list_empty([]).
%list_empty([_|_]):- fail.
% Checks if a value is a member of the given list
list_member([H|_],H).
list_member([_|T],X):- list_member(T,X).

% Concatenates 2 lists
list_append([], L, L).
list_append([X|Xs], Ys, [X|R]) :-
	list_append(Xs,Ys,R).

% Reverse a list
list_reverse([], []).
list_reverse([H|T], R) :-
	list_reverse(T, T1),
	list_append(T1, [H], R).

% Deleting all occurences of a given element from a list
list_delete_all([],_,[]).
list_delete_all([H|T],H,R) :-
	list_delete_all(T,H,T1),
	!,
	R = T1.
list_delete_all([H|T],X,R) :-
	list_delete_all(T,X,T1),
	R = [H|T1].

% Deleting one occurence of a given element from a list
list_delete_one([H|T], H, T).
list_delete_one([H|T], X, [H|R]) :-
	list_delete_one(T, X, R).

% Inserting one element in the list
% backtracking generates all possibilities
list_insert(Xs, X, R) :-
	list_delete_one(R,X,Xs).

% Return a list with only distinct values
list_unique([],[]).
list_unique([H|T],[H|R]) :-
	not(list_member(T,H)),
	!,
	list_unique(T,R).
list_unique([_|T],R) :-
	list_unique(T,R).

% Checks if a given list is the prefix of another one
list_prefix([],_).
list_prefix([H|P],[H|L]):-
	list_prefix(P,L).

% Checks if a given list is contained in another one.
list_infix([],_).
list_infix([H|T1],[H|T2]):-
	list_prefix(T1,T2).
list_infix(P,[_|T]):-
	list_infix(P,T).

% Zip
list_zip([],_,[]).
list_zip(_,[],[]).
list_zip([X|Xs],[Y|Ys],[pair(X,Y)|R]) :-
	list_zip(Xs, Ys, R).

% Unzip
list_unzip([],[],[]).
list_unzip([pair(X,Y)|L], [X|Xs], [Y|Ys]) :-
	list_unzip(L, Xs, Ys).

% Zip with Index
list_zip_with_index([],_,[]).
list_zip_with_index([X|Xs],N,[pair(X,N)|R]) :-
	N1 is N+1,
	list_zip_with_index(Xs, N1, R).

% Taking N first elements from a list
list_take(_,0,[]).
list_take([],N,[]) :- N > 0.
list_take([H|T],N,R) :-
	N > 0,
	N1 is N-1,
	list_take(T,N1,R1),
	R = [H|R1].

% Dropping N elements from a list
list_drop(L,0,L).
list_drop([],N,[]) :- N > 0.
list_drop([_|T],N,R) :-
	N > 0,
	N1 is N-1,
	list_drop(T,N1,R).

% Splitting a list at the Nth element
% This is equivalent to Take/Drop N
list_split([],_,[],[]).
list_split(Xs,0,[],Xs).
list_split(Xs,N,L,R) :-
	N > 0,
	list_take(Xs,N,L),
	list_drop(Xs,N,R).


%
%	List of numbers
%

% Find the maximum of a list
list_max([H],M) :- M is H.
list_max([H|T], M) :-
	list_max(T, M1), H >= M1, M is H.
list_max([H|T], M) :-
	list_max(T, M1), H < M1, M is M1.

% Find the minimum of a list
list_min([H], M) :- M is H.
list_min([H|T], M) :-
	list_min(T, M1), H =< M1, M is H.
list_min([H|T], M) :-
	list_min(T, M1), H > M1, M is M1.

% Sum the list
list_sum([], 0).
list_sum([H|T], R) :-
	list_sum(T,R1),
	R is H + R1.
	
% Product the list
list_product([], 0).
list_product([H], H).
list_product([H|T], R) :-
	list_product(T, R1),
	R is H * R1.


%
%	Sorting
%

% Merging sorted lists
list_merge(L,[],L).
list_merge([],R,R).
list_merge([H1|T1], [H2|T2], Merged) :-
	H1 < H2,
	list_merge(T1, [H2|T2], R1),
	Merged = [H1|R1].
list_merge([H1|T1], [H2|T2], Merged) :-
	list_merge([H1|T1], T2, R1),
	Merged = [H2|R1].

% Merge sort implementation
merge_sort([], []).
merge_sort([X], [X]).
merge_sort(Xs, Sorted) :-
	list_length(Xs, Len),
	Index is Len // 2,
	list_split(Xs, Index, Left, Right),
	merge_sort(Left, L1),
	merge_sort(Right, R1),
	list_merge(L1, R1, Sorted).


% Cartesian product of 2 lists
% Use findall(R,list_cp([1,2,3],[a,b,c],R), Res) if results need to be stored
list_cp(Xs,Ys,R) :-
	findall(X,list_cp_gen(Xs,Ys,X), R).

% Generates the cartesian product of 2 lists via backtracking
list_cp_gen(Xs,Ys,R) :-
	member(X,Xs),
	member(Y,Ys),
	R = pair(X,Y).
