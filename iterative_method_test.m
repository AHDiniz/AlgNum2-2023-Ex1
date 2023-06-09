function iterative_method_test (A, file_name, tol, nmaxiter, omega)
    n = rows(A);

    b = A * ones(n, 1);

    [x_jacobi, er_jacobi, iter_jacobi, time_jacobi] = jacobi(A, b, tol, nmaxiter);
    [x_seidel, er_seidel, iter_seidel, time_seidel] = seidel(A, b, tol, nmaxiter);
    [x_sor, er_sor, iter_sor, time_sor] = sor(A, b, tol, nmaxiter, omega);

    out_data = fopen(strcat("out/", file_name, "_iterative.txt"), "w");

    fprintf(out_data, "Matrix: %s\n", file_name);
    
    fprintf(out_data, "n: %d\n", n);
    fprintf(out_data, "Tolerance: %f\n", tol);
    fprintf(out_data, "Omega: %f\n", omega);
    
    fprintf(out_data, "Jacobi iterations: %d\n", iter_jacobi);
    fprintf(out_data, "Seidel iterations: %d\n", iter_seidel);
    fprintf(out_data, "SOR iterations: %d\n", iter_sor);

    fprintf(out_data, "Jacobi elapsed time: %d\n", time_jacobi);
    fprintf(out_data, "Seidel elapsed time: %d\n", time_seidel);
    fprintf(out_data, "SOR elapsed time: %d\n", time_sor);

    fclose(out_data);
    
    iter = max([iter_jacobi, iter_seidel, iter_sor]);

    er_jacobi_resize = zeros(iter, 1);
    for i = 1 : iter
        er_jacobi_resize(i) = er_jacobi(i);
    end

    er_seidel_resize = zeros(iter, 1);
    for i = 1 : iter
        er_seidel_resize(i) = er_seidel(i);
    end

    er_sor_resize = zeros(iter, 1);
    for i = 1 : iter
        er_sor_resize(i) = er_sor(i);
    end


    hf = figure();
    plot(1:iter, log(er_jacobi_resize), "r", 1:iter, log(er_seidel_resize), "g", 1:iter, log(er_sor_resize), "b");
    
    xlabel("Número de iterações");
    ylabel("Erro");

    legend("Jacobi", "Seidel", "SOR");

    title("Número de iterações x erro");

    print(hf, strcat("out/", file_name, "_iterative.png"), "-dpng");
end