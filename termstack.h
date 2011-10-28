#ifndef INCLUDED_TERMSTACK_H
#define INCLUDED_TERMSTACK_H

#include <list>
#include <numeric>

class TermStack
{
public:
    void push(int i);

    template<class F>
    int accumulate(F f) const
    {
        // Accumulate backwards, just for the heck of it
        return std::accumulate(m_terms.rbegin(), m_terms.rend(), 0, f);
    }

private:
    std::list<int> m_terms;
};

#endif
