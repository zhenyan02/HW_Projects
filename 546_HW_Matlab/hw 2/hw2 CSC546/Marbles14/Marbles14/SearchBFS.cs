using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marbles14
{
    class SearchBFS
    {
        public SearchBFS()
        {

        }

        public List<State> BreadthFirstSearch(State root)
        {
            List<State> PathToSolution = new List<State>();
            List<State> OpenList = new List<State>();
            List<State> ClosedList = new List<State>();

            OpenList.Add(root);
            bool ResultFound = false;

            while (OpenList.Count > 0 && !ResultFound)
            {
                //||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\
                //********************************************************\\
                // BFS ------ Add Right end and Remove Left end\\
                State currentState = OpenList[0];
                OpenList.RemoveAt(0);
                //********************************************************\\
                //||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\


                //Remove the State that expanded
                ClosedList.Add(currentState);

                //Output the numbers of remaining not solved states.
                Console.WriteLine(OpenList.Count());

                //Pefrom the the Breadth expanding to current State
                currentState.ExpandState();

                //Print solving path
                //currentState.PrintPuzzle();

                for (int i = 0; i < currentState.children.Count; i++)
                {
                    //Trace the parent for currentState
                    State currentChild = currentState.children[i];

                    //Check whether reach to expect result
                    if (currentChild.ResultTest())
                    {
                        Console.WriteLine("Result found.");
                        ResultFound = true;
                        //trace path to root
                        PathTrace(PathToSolution, currentChild);
                    }


                    //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\
                    //*************************************************************************\\
                    //Add into queue if currecnt state not duplicate\\
                    // BFS ------ Add Right end and Remove Left end\\
                    if (!Contains(OpenList, currentChild) && !Contains(ClosedList, currentChild))
                        OpenList.Add(currentChild);
                    //*************************************************************************\\
                    //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\

                }
            }


            return PathToSolution;
        }

        //Track Path
        public void PathTrace(List<State> path, State n)
        {
            Console.WriteLine("Tracing path...");
            State current = n;
            path.Add(current);

            while (current.parent != null)
            {
                current = current.parent;
                path.Add(current);

            }
        }
        // Check whether State occurred before
        // Work with DuplicatedState in Class State
        // to avoid endless moving loop
        public static bool Contains(List<State> list, State c)
        {
            bool contains = false;

            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].DuplicateState(c.puzzle))
                    contains = true;
            }
            return contains;
        }
    }
}
