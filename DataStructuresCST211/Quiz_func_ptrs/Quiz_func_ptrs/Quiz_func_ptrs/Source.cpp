#include <iostream>

using std::cout;
using std::cin;
using std::endl;

float displayNum(int n1, float n2) {

    cout << "The int number is " << n1 << endl;

    cout << "The double number is " << n2 << endl;

    return n1 + n2;
}



int main() {

    int num1 = 5;

    float num3, num2 = 5.5;

    float (*foo)(int, float);
    foo = displayNum;

    

    // calling the function

    num3 = foo(num1, num2);

    cout << "The sum is " << num3 << endl;



    return 0;

}