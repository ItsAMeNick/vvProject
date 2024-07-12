module vvProjectFSMBase

/*
This module will define all facts that are needed to define the underlying structure of the Finite State Machine (FSM)
*/

one sig FSM {
	currentState: one State
}

/*
In this representation of an FSM, states will have simple transitions represented by outgoing edges.
*/
abstract sig State {
	nextState: set State
}

/*
In this representation of an FSM, all nodes must be reachable
*/
fact AllNodesReachable {
	all s: State | s in FSM.currentState.*nextState
}

/*
In this representation, it may be necessary to work with an acyclic FSM, but not all the time.  This is therefor
defined as a predicate so that it may be optionally checked.
*/
pred Acyclic {
	no s: State | s in s.^nextState
}
