files = {"bcsstm02", "gre_115", "1138_bus"};
tol = cell(3, 1);
max_iter = cell(3, 1);
omega = cell(3, 1);

tol{1} = 0.0001;
max_iter{1} = 1000;
omega{1} = 0.8;

tol{2} = 0.0001;
max_iter{2} = 1000;
omega{2} = 0.8;

tol{3} = 0.0001;
max_iter{3} = 1000;
omega{3} = 0.8;

for i = 1 : 3

    filename = sprintf("in/%s.mat", files{i});

    S = load(filename);
    
    A = S.Problem.A;

    [d, is_diag_dom] = test_matrix(A, files{i});

    if d == 0.0
        
        printf("Cannot use matrix %s.\n", files{i});
    
    else

        direct_method_test(A, files{i});
        iterative_method_test(A, files{i}, tol{i}, max_iter{i}, omega{i});

    end
end