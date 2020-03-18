using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marbles14
{
    class Program
    {
        static void Main(string[] args)
        {
            //Input Value row*col
            int[] puzzle =
            {
                1,-1,-1,-1,-1,
                1, 1,-1,-1,-1,
                1, 1, 1,-1,-1,
                1, 1, 1, 1,-1,
                1, 1, 0, 1, 1
            };

            int a = 1;

            while(a!=2)
            {
                Console.WriteLine("Press 0 for DFS");
                Console.WriteLine("Press 1 for BFS");
                Console.WriteLine("Press 2 to exit");

                State root = new State(puzzle);
                String val = Console.ReadLine();
                a = Convert.ToInt32(val);
                List<State> solution;

                if (a == 1)
                {
                    //BFS Method
                    SearchBFS uiBFS = new SearchBFS();
                    List<State> solutionBFS = uiBFS.BreadthFirstSearch(root);
                    solution = solutionBFS;
                }
                else
                {
                   if (a == 0)
                    {
                        //DFS Method
                        SearchDFS uiDFS = new SearchDFS();
                        List<State> solutionDFS = uiDFS.DepthFirstSearch(root);
                        solution = solutionDFS;
                    }
                    else { break; }
                }
                    


                    //Print result or no result found
                    if (solution.Count > 0)
                {
                    solution.Reverse();
                    for (int i = 0; i < solution.Count; i++)
                        solution[i].PrintPuzzle();
                }
                else
                {
                    Console.WriteLine("No path to solution is found");
                }

            }
        }
    }
}
