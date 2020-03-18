using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PuzzleQuestion
{
    class SearchDFS
    {
        public SearchDFS()
        {

        }

        public List<State> DepthFirstSearch(State root)
        {
            List<State> PathToSolutionDFS = new List<State>();
            List<State> OpenListDFS = new List<State>();
            List<State> ClosedListDFS = new List<State>();

            OpenListDFS.Add(root);
            bool ResultFound = false;

            while (OpenListDFS.Count > 0 && !ResultFound)
            {
                //||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\
                //********************************************************\\
                // DFS ------ Add Right end and Remove Right end\\
                State currentState = OpenListDFS[OpenListDFS.Count()-1];
                OpenListDFS.RemoveAt(OpenListDFS.Count() - 1);
                //||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\
                //********************************************************\\

                ClosedListDFS.Add(currentState);

                Console.WriteLine(OpenListDFS.Count());

                //Pefrom the the Breadth expanding to current State
                currentState.ExpandState();
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
                        PathTraceDFS(PathToSolutionDFS, currentChild);
                    }


                    //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\
                    //*************************************************************************************\\
                    //Add into queue if currecnt state not duplicate\\
                    // DFS ------ Add Right end and Remove Right end\\ 
                    if (!ContainsDFS(OpenListDFS, currentChild) && !ContainsDFS(ClosedListDFS, currentChild))
                        OpenListDFS.Add(currentChild);
                    //*************************************************************************************\\
                    //|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||\\
                }
            }


            return PathToSolutionDFS;
        }

        //Track Path
        public void PathTraceDFS(List<State> path, State n)
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
        public static bool ContainsDFS(List<State> list, State c)
        {
            bool ContainsDFS = false;

            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].DuplicateState(c.puzzle))
                    ContainsDFS = true;
            }
            return ContainsDFS;
        }
    }
}
