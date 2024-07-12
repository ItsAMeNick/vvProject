open vvProjectFSMBase as fsm

/*
This context is specific to one instance of the chatbot
*/
one sig Context {
	orderNumber: lone Int
}

/*
Singleton states
*/
one sig Start, End extends fsm/State {
	// Here WE COULD ADD RELATIONS TO THE STATES
	//context: Context
}

/*
States that can appear multiple times
*/
sig Escalation, OrderQuery, OrderStatus, CancelOrder extends fsm/State {
	// Here WE COULD ADD RELATIONS TO THE STATES
	//context: Context
}

/*
This chatbot itself is an FSM with a reference to a global context that is used to gather data about the
conversation.  Its not like its fallen out of a coconut tree, everything existing with the context of
what has come before
*/
one sig Chatbot extends fsm/FSM {
    context: one Context
}

/*
The start state should not be a viable next step for any other state
*/
fact StartIsSourceOnly {
	no s: fsm/State | Start in s.nextState
}

/*
The end state should not have next step
*/
fact EndIsSinkOnly {
	no End.nextState
}

/*
The start state may move to any other state
*/
fact StartMayMoveToAnyState {
	all s: fsm/State | s != Start => s in Start.nextState
}

/*
The end state is a viable nextState from all other states
*/
fact EndMayBeTargetOfAnyState {
	all s: fsm/State | s != End => End in s.nextState
}

/*
All states may move to escalation, except for the end state
*/
fact IfAbleAllStatesMayEscalate {
	all s: fsm/State | s != End => Escalation in s.nextState
}

/*
The OrderQueryState
*/

run {} for exactly 1 Escalation, 3 OrderQuery, 1 OrderStatus, 1 CancelOrder
