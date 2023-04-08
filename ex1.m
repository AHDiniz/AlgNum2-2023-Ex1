files = {"bcsstm02", "gre_115", "1138_bus", "steam3", "494_bus"};
tol = cell(5, 1);
max_iter = cell(5, 1);
omega = cell(5, 1);

tol{1} = 0.000001;
max_iter{1} = 100;
omega{1} = 1.2;

tol{2} = 0.0001;
max_iter{2} = 70;
omega{2} = 0.8;

tol{3} = 0.0001;
max_iter{3} = 360;
omega{3} = 0.4;

tol{4} = 0.000001;
max_iter{4} = 90;
omega{4} = 0.8;

tol{5} = 0.00001;
max_iter{5} = 2000;
omega{5} = 0.8;

for i = 5

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