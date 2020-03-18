// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file

#ifndef PCH_H
#define PCH_H
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <cassert>
#include <fstream>
#include <sstream>

using namespace std;

struct Link
{
	double weight;
	double WeightAduj;
};

class Node;

typedef vector<Node> Layer;



// ****************************************************************************** \\
// ********************************  class Node  ******************************** \\
// ||||||||||||||||||||||||||||||||  start here  |||||||||||||||||||||||||||||||| \\

class Node
{
public:
	Node(unsigned totalOuts, unsigned nodeID);
	void setOutVal(double val) { curr_outVal = val; }
	double getOutVal(void) const { return curr_outVal; }
	void feedForward(const Layer &fromLayer);
	void derivativesOut(double targetVal);
	void derivativesHidden(const Layer &toLayer);
	void updateInWeights(Layer &fromLayer);
private:
	static double learnRate;   // learning rate
	static double a; // weight change momentum
	static double actiFunc(double x);
	static double actiFuncDerivative(double x);
	static double randomWeight(void) { return rand() / double(RAND_MAX); }
	double sumDerivative(const Layer &toLayer) const;
	double curr_outVal;
	vector<Link> curr_outWeights;
	unsigned curr_nodeID;
	double curr_Derivative;
};

// ||||||||||||||||||||||||||||||||   end here   |||||||||||||||||||||||||||||||| \\
// ********************************  class Node  ******************************** \\
// ****************************************************************************** \\




// ****************************************************************************** \\
// ********************************   class MLP  ******************************** \\
// ||||||||||||||||||||||||||||||||  start here  |||||||||||||||||||||||||||||||| \\

class MLP
{
public:
	MLP(const vector<unsigned> &topo);
	void feedForward(const vector<double> &inVals);
	void backProp(const vector<double> &targetVals);
	void getResults(vector<double> &resultVals) const;
	double getRecentAverageError(void) const { return curr_recentAverageError; }

private:
	//curr_layers is a matrix, can access to certain node with [layerID][NodeNum]
	vector<Layer> curr_layers;
	double curr_error;
	double curr_recentAverageError;
	static double curr_recentAverageSmoothingFactor;
};

// ||||||||||||||||||||||||||||||||   end here   |||||||||||||||||||||||||||||||| \\
// ********************************  class MLP   ******************************** \\
// ****************************************************************************** \\





// read in data from training data.
class TrainingSample
{
public:
	TrainingSample(const string filename);
	bool fileEof(void) { return curr_trainingSampleFile.eof(); }
	void readTopo(vector<unsigned> &topo); 	// read in MLP topo from training data.

	unsigned readNextIns(vector<double> &inVals);	// read in input vals from training data
	unsigned readTargetOuts(vector<double> &targetOutVals);	 // read in target vals from training data.

private:
	ifstream curr_trainingSampleFile;
};

// TODO: add headers that you want to pre-compile here

#endif //PCH_H
