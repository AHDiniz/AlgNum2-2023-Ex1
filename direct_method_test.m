function direct_method_test (A, file_name)
    [L, U, P, Q] = lu(A);

    n = rows(A);

    hf = figure();
    spy(A);
    print(hf, strcat("out/", file_name, "_spy_A.png"), "-dpng");

    hf = figure();
    spy(L);
    print(hf, strcat("out/", file_name, "_spy_L.png"), "-dpng");

    hf = figure();
    spy(U);
    print(hf, strcat("out/", file_name, "_spy_U.png"), "-dpng");

    fill_rate = 100.0 - (nnz(A) / (nnz(L) + nnz(U))) * 100.0;

    solution = ones(n, 1);
    
    b = A * solution;

    x = A \ b;

    solution_error = norm(solution - x, inf) / norm(x, inf);

    matrix_error = norm(P * A - L * U, inf) / norm(A, inf);

    b_error = norm(A * (solution - x), inf) / norm(b, inf);

    residual_norm = norm(b - A * x, inf);

    conditioning = cond(A);

    out_data = fopen(strcat("out/", file_name, "_direct.txt"), "w");

    fprintf(out_data, "Matrix : %s\n", file_name);
    fprintf(out_data, "n: %d\n", n);
    fprintf(out_data, "Fill rate: %f\n", fill_rate);
    fprintf(out_data, "Solution error: %f\n", solution_error);
    fprintf(out_data, "Matrix error: %f\n", matrix_error);
    fprintf(out_data, "b error: %f\n", b_error);
    fprintf(out_data, "Residual norm: %f\n", residual_norm);
    fprintf(out_data, "Conditioning: %f\n", conditioning);

    fclose(out_data);
end