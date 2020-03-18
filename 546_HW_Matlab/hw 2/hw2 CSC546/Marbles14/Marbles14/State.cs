using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Marbles14
{
    //Class State that handle moving and check duplicate State
    class State
    {
        public List<State> children = new List<State>();
        public State parent;
        public int x = 0;
        public int row = 5;
        public int col = 5;
        public int[] puzzle = new int[25];

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
                {
                    x = i;
                    if (i < 23)
                        Moving0(puzzle, x);
                    if (i > 9)
                        Moving45(puzzle, x);
                    if (i > 11)
                        Moving135(puzzle, x);
                    if (i > 1)
                        Moving180(puzzle, x);
                    if (i < 15)
                        Moving225(puzzle, x);
                    if (i < 13)
                        Moving315(puzzle, x);
                }
            }
            //children[0].PrintPuzzle();
            //children[1].PrintPuzzle();
            //children[2].PrintPuzzle();
            //children[3].PrintPuzzle();
        }

        //Move "180" degree, if possible
        public void Moving0(int[] p, int i)
        {
            if ((puzzle[i+1] == 1)&&(puzzle[i+2] == 1))
            {
                int[] pc = new int[25];
                CopyState(pc, p);

                pc[i + 0] = 1;
                pc[i + 1] = 0;
                pc[i + 2] = 0;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "45" degree, if possible
        public void Moving225(int[] p, int i)
        {
            if ((puzzle[i + 5] == 1) && (puzzle[i + 10] == 1))
            {
                int[] pc = new int[25];
                CopyState(pc, p);

                pc[i + 0] = 1;
                pc[i + 5] = 0;
                pc[i +10] = 0;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "0" degree, if possible
        public void Moving180(int[] p, int i)
        {
            if ((puzzle[i - 1] == 1) && (puzzle[i - 2] == 1))
            {
                int[] pc = new int[25];
                CopyState(pc, p);

                pc[i - 0] = 1;
                pc[i - 1] = 0;
                pc[i - 2] = 0;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "-135" degree, if possible
        public void Moving45(int[] p, int i)
        {
            if ((puzzle[i - 5] == 1) && (puzzle[i - 10] == 1))
            {
                int[] pc = new int[25];
                CopyState(pc, p);

                pc[i - 0] = 1;
                pc[i - 5] = 0;
                pc[i -10] = 0;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "135" degree, if possible
        public void Moving315(int[] p, int i)
        {
            if ((puzzle[i + 6] == 1) && (puzzle[i + 12] == 1))
            {
                int[] pc = new int[25];
                CopyState(pc, p);

                pc[i + 0] = 1;
                pc[i + 6] = 0;
                pc[i +12] = 0;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        //Move "-45" degree, if possible
        public void Moving135(int[] p, int i)
        {
            if ((puzzle[i - 6] == 1) && (puzzle[i - 12] == 1))
            {
                int[] pc = new int[25];
                CopyState(pc, p);

                pc[i - 0] = 1;
                pc[i - 6] = 0;
                pc[i -12] = 0;

                State child = new State(pc);
                children.Add(child);
                child.parent = this;
            }
        }

        public void PrintPuzzle()
        {
            Console.WriteLine();
            int m = 0;
            for (int i = 0; i < row; i++)
            {
                if (i == 0)
                    Console.Write("    ");
                if (i == 1)
                    Console.Write("   ");
                if (i == 2)
                    Console.Write("  ");
                if (i == 3)
                    Console.Write(" ");

                for (int j = 0; j < col; j++)
                {
                    if (puzzle[m] == 1)
                        Console.Write(" *");
                    if (puzzle[m] == 0)
                        Console.Write(" O");
                    m++;
                }
                Console.WriteLine();
            }
        }

        // Check whether two States are duplicated or not
        // Work with Contain Function in Search to avoid endless moving loop
        public bool DuplicateState(int[] p)
        {
            bool sameState = true;
            for (int i = 0; i < p.Length; i++)
            {
                if (puzzle[i] != p[i])
                {
                    sameState = false;
                }
            }
            return sameState;
        }

        //Copy previous State before moving
        public void CopyState(int[] a, int[] b)
        {
            for (int i = 0; i < b.Length; i++)
            {
                a[i] = b[i];
            }
        }

        //Check whether this State is the result
        public bool ResultTest()
        {
            bool isResult = true;
            int m = 0;

            for (int i = 0; i < puzzle.Length; i++)
            {
                if (puzzle[i] == 1)
                    m++;
                if (m > 1)
                    isResult = false;
            }
            return isResult;
        }
    }
}
