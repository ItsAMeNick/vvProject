open vvProjectFSMBase as fsm

one sig Context {
	orderIdentifier: lone String
}

one sig Start, End, Escalation, OrderQuery, OrderStatus, CancelOrder extends fsm/State {
	// Here WE COULD ADD RELATIONS TO THE STATES
	//context: Context
}

one sig Chatbot extends fsm/FSM {
    context: one Context
}
