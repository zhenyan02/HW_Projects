#include "pch.h"
#include <cmath>
#include <cstdlib>
#include <iostream>
#include <vector>
#include <cassert>
#include <fstream>
#include <sstream>


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
	//mylayers[layerID][NodeNum]
	vector<Layer> curr_layers;
	double curr_error;
	double curr_recentAverageError;
	static double curr_recentAverageSmoothingFactor;
};



