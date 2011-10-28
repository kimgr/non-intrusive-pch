#include "calculator.h"
#include <iostream>

int main(int argc, char* argv[])
{
    Calculator calc;
    calc.add(100);
    calc.add(20);
    calc.add(34);

    std::cout << "Sum is: " << calc.sum() << std::endl;
    return 0;
}
