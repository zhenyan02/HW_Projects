#include "pch.h"

// read in MLP topo from training data.
void TrainingSample::readTopo(vector<unsigned> &topo)
{
	string line;
	string arr;

	getline(curr_trainingSampleFile, line);
	stringstream ss(line);
	ss >> arr;
	if (this->fileEof() || arr.compare("topology:") != 0) {
		cout << "wrong format";
	}

	while (!ss.eof()) {
		unsigned n;
		ss >> n;
		topo.push_back(n);
	}

	return;
}

TrainingSample::TrainingSample(const string filename)
{
	curr_trainingSampleFile.open(filename.c_str());
}

// read in input vals from training data
unsigned TrainingSample::readNextIns(vector<double> &inVals)
{
	inVals.clear();

	string line;
	getline(curr_trainingSampleFile, line);
	stringstream ss(line);

	string arr;
	ss >> arr;
	if (arr.compare("in:") == 0) {
		double oneValue;
		while (ss >> oneValue) {
			inVals.push_back(oneValue);
		}
	}

	return inVals.size();
}

// read in target vals from training data.
unsigned TrainingSample::readTargetOuts(vector<double> &targetOutVals)
{
	targetOutVals.clear();

	string line;
	getline(curr_trainingSampleFile, line);
	stringstream ss(line);

	string arr;
	ss >> arr;
	if (arr.compare("out:") == 0) {
		double oneValue;
		while (ss >> oneValue) {
			targetOutVals.push_back(oneValue);
		}
	}

	return targetOutVals.size();
}