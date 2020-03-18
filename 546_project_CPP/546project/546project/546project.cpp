// 546project.cpp : This file contains the 'main' function. Program execution begins and ends there.

#include "pch.h"

void displayVector(string arr, vector<double> &v)
{
	cout << arr << " ";
	for (unsigned i = 0; i < v.size(); ++i) {
		cout << v[i] << " ";
	}

	//cout << endl;
}



int main()
{
	TrainingSample trainData("in_xyContinues.txt");

	// MLP topology
	vector<unsigned> topo;
	trainData.readTopo(topo);
	MLP myMLP(topo);
	vector<double> inVals, targetVals, resultVals;
	int trainingPass = 0;

	//*****************************************************************//
	// Please RELEASE following code to write output into certain file
	//ofstream out("out_xyContinues.txt");
	//streambuf *coutbuf = cout.rdbuf(); //save old buf
	//cout.rdbuf(out.rdbuf()); //redirect std::cout to out.txt!



	while (!trainData.fileEof()) {
		++trainingPass;


		cout<< "TraningSample: " << trainingPass;

		// Read in new data and feed forward the data
		if (trainData.readNextIns(inVals) != topo[0]) {
			break;
		}
		displayVector("  Input:", inVals);
		myMLP.feedForward(inVals);


		//MLP training with target vals:
		trainData.readTargetOuts(targetVals);
		displayVector("  Target:", targetVals);
		assert(targetVals.size() == topo.back());

		// get the MLP calculated results:
		myMLP.getResults(resultVals);
		displayVector("  Output:", resultVals);

		myMLP.backProp(targetVals);

		cout << "  MLP current average error: "
			<< myMLP.getRecentAverageError() << endl;
	}

	cout << endl << "Topology of MLP: " << endl;

	for (int i = 0; i < topo.size(); ++i)
	{
		cout << topo[i] << ' ';
	}

	cout << endl << "End" << endl;
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu
// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Out window to see build out and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
