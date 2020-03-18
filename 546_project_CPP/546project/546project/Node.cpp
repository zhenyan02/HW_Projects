#include "pch.h"

double Node::learnRate = 0.35;  // MLP learning rate 
double Node::a = 0.5; //WeightAduj momentum multiplier

// Update the weights with learning rate and trend of old weights.
void Node::updateInWeights(Layer &fromLayer)
{

	for (unsigned n = 0; n < fromLayer.size(); ++n)
	{
		Node &Node = fromLayer[n];
		double oldWeightAduj = Node.curr_outWeights[curr_nodeID].WeightAduj;

		// dW = learnRate*error*d(phi)*y
		// y = phi[sum(w*y)] = "curr_Derivative"
		// error*d(phi) = "Node.getOutVal()"
		double newWeightAduj = learnRate * Node.getOutVal() * curr_Derivative + a * oldWeightAduj;

		Node.curr_outWeights[curr_nodeID].WeightAduj = newWeightAduj;
		Node.curr_outWeights[curr_nodeID].weight += newWeightAduj; //W_new = W_old + W_adjust;
	}

}

//Sum of errors at nodes we feed which is error in dW = learnRate*error*d(phi)*y
double Node::sumDerivative(const Layer &toLayer) const
{
	double sum = 0.0;

	for (unsigned n = 0; n < toLayer.size() - 1; ++n)
	{
		// Sum of error which is e in equation 
		sum += curr_outWeights[n].weight * toLayer[n].curr_Derivative;
	}

	return sum;
}

void Node::derivativesHidden(const Layer &toLayer)
{
	double d = sumDerivative(toLayer);
	// d(phi) = actiFuncDerivative(curr_outVal)
	curr_Derivative = d * Node::actiFuncDerivative(curr_outVal);
}

void Node::derivativesOut(double targetVal)
{
	double d = targetVal - curr_outVal;
	curr_Derivative = d * Node::actiFuncDerivative(curr_outVal);
}

// Activation Function
double Node::actiFunc(double x)
{
	return tanh(x);
}

// Derivative of Activation Function
double Node::actiFuncDerivative(double x)
{
	//d(tanh)/dx ~= 1-x^2 
	return 1 - x * x;
}

// Calculate the outputs of each nodes
void Node::feedForward(const Layer &fromLayer)
{
	double sum = 0.0;

	for (unsigned n = 0; n < fromLayer.size(); ++n)
	{
		// Sum all inputs*weights = sum(w*y)
		sum += fromLayer[n].getOutVal()*fromLayer[n].curr_outWeights[curr_nodeID].weight;
	}
	// y = phi[sum(w*y)] = actiFunc(sum)
	curr_outVal = Node::actiFunc(sum);
}


Node::Node(unsigned totalOuts, unsigned nodeID)
{
	for (unsigned c = 0; c < totalOuts; ++c)
	{
		curr_outWeights.push_back(Link());
		// Initail weight
		curr_outWeights.back().weight = randomWeight();
	}

	curr_nodeID = nodeID;
}
