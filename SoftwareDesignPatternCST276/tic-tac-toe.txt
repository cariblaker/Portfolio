#include <iostream>

using std::cout;
using std::cin;
using std::endl;

int menu(void);
void play_X(char*);
void play_O(char*);


int main()
{
	cout << "\nWelcome. Let's play Tic-Tac-Toe.\n";

	const char* board[5][5] = { 
					{ " ", "|", " ", "|", " " },
					{"-", "-" , "-" , "-" , "-" },
					{ " ", "|", " ", "|", " " },
					{"-", "-" , "-" , "-" , "-" },
					{ " ", "|", " ", "|", " " }
	};

	for (int i = 0; i < 5; i++)
	{
		for (int j = 0; j < 5; j++)
		{
			cout << board[i][j];
		}
		cout << "\n";
	}

	//my preliminary board didn't allow for much playing but it was much cuter
	//cout << "\t\t|\t|\t" << endl;
	//cout << "\t__________________________" << endl;
	//cout << "\t\t|\t|\t" << endl;
	//cout << "\t__________________________" << endl;
	//cout << "\t\t|\t|\t" << endl;

	
	play_X(board);		//gosh I can't remember how to pass pointers properly

	return 0;
}



int menu()
{
	int choice;
	cout << "Where would you like to place your mark? Enter the corresponding number: " << endl;
	cout << "1. Upper Left\n2. Upper Mid\n3.Upper Right\n4. Middle Left\n5. Middle\n6. Middle Right\n7. Lower Left\n8. Lower Mid\n9. Lower Right\n" << endl;
	cin >> choice;

	return choice;
}


void play_X(char* board)
{
	int spot = menu();

	if (spot == 1)
		//there's still soooo much to do...

		play_O(board);
}

void play_O(char* board)
{

	play_X(board);
}