#include <octave/oct.h>
#include <cmath>

DEFUN_DLD(diag_dominant, args, nargout, "Checks if the given matrix A is diagonally dominant")
{
    Matrix A = args(0).matrix_value();
    const int n = A.rows();
    
    octave_value_list retval(nargout);

    for (int i = 0; i < n; ++i)
    {
        double sum = 0.0;
        
        for (int j = 0; j < n; ++j)
        {
            sum += fabs(A(i,j));
        }
        
        sum -= fabs(A(i,i));

        if (sum >= fabs(A(i,i)))
        {
            retval(0) = "FALSE";
            return retval;
        }
    }

    retval(0) = "TRUE";
    return retval;
}