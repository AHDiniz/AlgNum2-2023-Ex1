#include <octave/oct.h>
#include <ctime>
#include <cmath>

inline double inf_norm(ColumnVector v)
{
    double max = 0.0;
    for (int i = 0; i < v.numel(); ++i)
    {
        double value = fabs(v(i));
        if (value >= max)
        {
            max = value;
        }
    }
    return max;
}

DEFUN_DLD(jacobi, args, nargout, "This function implements the iterative Gauss-Jacobi method for Ax = b linear systems.")
{
    Matrix A           = args(0).matrix_value();
    ColumnVector b     = args(1).column_vector_value();
    const double tol   = args(2).double_value();
    const int max_iter = args(3).int_value();

    const int n = A.rows();

    ColumnVector x0(n);
    x0.fill(0.0);

    ColumnVector x(n);
    x = x0;

    ColumnVector er(max_iter);
    er.fill(0.0);
    er(0) = 1.0;

    octave_idx_type iter = 0;

    double time_start = (double)clock() / (double)CLOCKS_PER_SEC;

    while (er(iter) > tol && iter < max_iter)
    {
        for (int i = 0; i < n; ++i)
        {
            double sum = 0.0;
            for (int j = 0; j < i; ++j)
                sum += A(i,j) * x0(j);
            for (int j = i + 1; j < n; ++j)
                sum += A(i,j) * x0(j);
            x(i) = (b(i) - sum) / A(i,i);
        }
        
        ++iter;
        
        double diff_norm = inf_norm((x - x0));
        double x_norm    = inf_norm(x);

        x_norm = x_norm == 0.0 ? 1.0 : x_norm;
        
        er(iter) = diff_norm / x_norm;

        x0 = x;
    }

    double time_end = (double)clock() / (double)CLOCKS_PER_SEC;

    er.resize(iter, 1);

    octave_value_list retval(nargout);
    
    retval(0) = x;
    retval(1) = er;
    retval(2) = iter;
    retval(3) = time_end - time_start;

    return retval;
}
