#include "pch.h"

double MLP::curr_recentAverageSmoothingFactor = 3000.0; // Total counts of training samples for averaging


void MLP::getResults(vector<double> &resultVals) const
{
	resultVals.clear();

	for (unsigned n = 0; n < curr_layers.back().size() - 1; ++n) {
		resultVals.push_back(curr_layers.back()[n].getOutVal());
	}
}

// Back-propagation
void MLP::backProp(const vector<double> &targetVals)
{
	// Calculate total MLP error which is (sum Node errors)^0.5

	Layer &outLayer = curr_layers.back();
	curr_error = 0.0;

	for (unsigned n = 0; n < outLayer.size() - 1; ++n)
	{
		double delta = targetVals[n] - outLayer[n].getOutVal();
		curr_error += delta * delta; //error^2
	}
	curr_error /= outLayer.size() - 1; // average error^2
	curr_error = sqrt(curr_error); // (error^2)^0.5

	// Calculate current average error
	// currAveError = (preSumError + currError)/(PrevTotalSamples +1)

	curr_recentAverageError =
		(curr_recentAverageError * curr_recentAverageSmoothingFactor + curr_error)
		/ (curr_recentAverageSmoothingFactor + 1.0);

	// Calculate out layer Derivatives

	for (unsigned n = 0; n < outLayer.size() - 1; ++n)
	{
		outLayer[n].derivativesOut(targetVals[n]);
	}

	// Calculate Derivatives of hidden layers

	for (unsigned layerID = curr_layers.size() - 2; layerID > 0; --layerID)
	{
		Layer &hiddenLayer = curr_layers[layerID];
		Layer &toLayer = curr_layers[layerID + 1];

		for (unsigned n = 0; n < hiddenLayer.size(); ++n)
		{
			hiddenLayer[n].derivativesHidden(toLayer);
		}
	}

	
	// update Link weights
	for (unsigned layerID = curr_layers.size() - 1; layerID > 0; --layerID)
	{
		Layer &layer = curr_layers[layerID];
		Layer &fromLayer = curr_layers[layerID - 1];

		for (unsigned n = 0; n < layer.size() - 1; ++n)
		{
			layer[n].updateInWeights(fromLayer);
		}
	}
}

// Feed forward
void MLP::feedForward(const vector<double> &inVals)
{
	assert(inVals.size() == curr_layers[0].size() - 1);

	// Assign (latch) the in values into the in Nodes
	for (unsigned i = 0; i < inVals.size(); ++i)
	{
		curr_layers[0][i].setOutVal(inVals[i]);
	}

	// Foward propagate
	for (unsigned layerID = 1; layerID < curr_layers.size(); ++layerID)
	{
		Layer &fromLayer = curr_layers[layerID - 1];
		for (unsigned n = 0; n < curr_layers[layerID].size() - 1; ++n)
		{
			curr_layers[layerID][n].feedForward(fromLayer);
		}
	}

}

MLP::MLP(const vector<unsigned> &topo)
{
	unsigned totalLayers = topo.size();
	for (unsigned layerID = 0; layerID < totalLayers; ++layerID)
	{
		curr_layers.push_back(Layer());
		unsigned totalOuts = layerID == topo.size() - 1 ? 0 : topo[layerID + 1];

		// Push the nodes into correspond layer
		for (unsigned NodeNum = 0; NodeNum <= topo[layerID];++NodeNum)
		{
			curr_layers.back().push_back(Node(totalOuts, NodeNum));
		}
		curr_layers.back().back().setOutVal(1.0); // bias node y0 always = 1
	}
}
