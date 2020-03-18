using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PuzzleQuestion
{
    //Class State that handle moving and check duplicate State
    class State
    { 
        public List<State> children = new List<State>();
        public State parent;
        public int x = 0;
        public int row = 3;
        public int col = 3;
        public int[] puzzle = new int[9];

        public State(int[] p)
        {
            SetPuzzle(p);
        }
        
        //Grab input
        public void SetPuzzle(int[] p)
        {
            for (int i = 0; i < puzzle.Length; i++)
                this.puzzle[i] = p[i];
        }

        //Move "0" to every possible directions
        public void ExpandState()
        {
            for (int i = 0; i < puzzle.Length; i++)
            {
                if (puzzle[i] == 0)
                    x = i;
            }

            RightMoving(puzzle, x);
            DownMoving(puzzle, x);
            LeftMoving(puzzle, x);
            UpMoving(puzzle, x);
            //children[0].PrintPuzzle();
            //children[1].PrintPuzzle();
            //children[2].PrintPuzzle();
            //children[3].PrintPuzzle();
        }

        //Move "0" Right, if possible
        public void RightMoving(int[] p, int i)
        {
            if(i % col < col - 1)
            {
                int[] pc = new int[row*col];
                CopyState(pc, p);

                int temp = pc[i + 1];
                pc[i + 1] = pc[i];
                pc[i] = temp;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "0" Down, if possible
        public void DownMoving(int[] p, int i)
        {
            if (i + col < puzzle.Length)
            {
                int[] pc = new int[row * col];
                CopyState(pc, p);

                int temp = pc[i + col];
                pc[i + col] = pc[i];
                pc[i] = temp;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "0" Left, if possible
        public void LeftMoving(int[] p, int i)
        {
            if (i % col > 0)
            {
                int[] pc = new int[row * col];
                CopyState(pc, p);

                int temp = pc[i - 1];
                pc[i - 1] = pc[i];
                pc[i] = temp;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "0" Up, if possible
        public void UpMoving(int[] p, int i)
        {
            if (i - col >= 0)
            {
                int[] pc = new int[row * col];
                CopyState(pc, p);

                int temp = pc[i - col];
                pc[i - col] = pc[i];
                pc[i] = temp;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        public void PrintPuzzle()
        {
            Console.WriteLine();
            int m = 0;
            for(int i=0; i<row; i++)
            {
                for (int j = 0; j < col; j++)
                {
                    Console.Write(puzzle[m] + " ");
                    m++;
                }
                Console.WriteLine();
            }
        }

        // Check whether two States are duplicated or not
        // Work with Contain Function in Search
        // to avoid endless moving loop
        public bool DuplicateState(int[] p)
        {
            bool sameState = true;
            for (int i = 0; i < p.Length; i++)
            {
                if(puzzle[i] != p[i])
                {
                    sameState = false;
                }
            }
            return sameState;
        }

        //Copy previous State before moving
        public void CopyState(int[] a, int[] b)
        {
            for(int i=0; i<b.Length; i++)
            {
                a[i] = b[i];
            }
        }

        //Check whether this State is the result
        public bool ResultTest()
        {
            bool isResult = true;
            int m = puzzle[0];

            for(int i=1; i<puzzle.Length; i++)
            {
                if (m > puzzle[i])
                    isResult = false;
                m = puzzle[i];
            }
            return isResult;
        }
    }
}
