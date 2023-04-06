files = cell(3, 1);

files{1} = "";
files{2} = "";
files{3} = "";

for i = 1 : 3:
    load(strcat("in/", files{i}, ".mat"));
    
    A = Problem.A;

    [d, is_diag_dom] = test_matrix(A, files{i});

    if d == 0.0:
        printf("Cannot use matrix %s.\n", files{i});
    else:

        direct_method_test(A, files{i});
        iterative_method_test(A, files{i}, 0.001, 1000, 0.8);

    end
end