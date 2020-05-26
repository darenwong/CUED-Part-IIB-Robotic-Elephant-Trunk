function check = check_valid_shape(x)
% Used with solve_taskspace_2_segment.m to check if a generated robot configuration is valid

    check = 0;
    check_counter = 0;
    theta = [x(1) x(3) x(5) x(7) x(9) x(11) x(13) x(15)];

    for n = 1:8
        for i = 1:(length(theta)-n+1)
            if abs(sum(theta(i:(i+n-1)))) < 5/6*2*pi
                check_counter = check_counter + 1;
            end
        end
    end

    
    if check_counter < 36
        check = 0;
    else
        check = 1;
    end
end
                