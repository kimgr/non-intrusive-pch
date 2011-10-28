#ifndef INCLUDED_CALCULATOR_H
#define INCLUDED_CALCULATOR_H

#include "termstack.h"

class Calculator
{
public:
    Calculator();

    void add(int i);
    int sum() const;

private:
    TermStack m_terms;
};

#endif
