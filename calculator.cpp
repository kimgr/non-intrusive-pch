#include "calculator.h"

#include <functional>

#ifdef _WIN32
#include <windows.h>
#include <iostream>
#endif

Calculator::Calculator()
{
#ifdef _WIN32
    DWORD foo = GetTickCount();
    std::cout << "We're built for Windows! Current tick count: " << foo << std::endl;
#endif
}

void Calculator::add(int i)
{
    m_terms.push(i);
}

int Calculator::sum() const
{
    return m_terms.accumulate(std::plus<int>());
}
