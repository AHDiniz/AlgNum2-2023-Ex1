function [d, is_diag_dom] = test_matrix (A, file_name)
    d = det(A);
    is_diag_dom = diag_dominant(A);

    out_data = fopen(strcat("out/", file_name, "_test.txt"), "w");

    fprintf(out_data, "Matrix : %s\n", file_name);
    fprintf(out_data, "Determinant: %f\n", d);
    fprintf(out_data, "Is diag. dom.: %s\n", is_diag_dom);

    fclose(out_data);
end