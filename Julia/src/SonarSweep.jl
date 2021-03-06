using DelimitedFiles
cur_dir = pwd()
inp_path = cur_dir * "/input/day1.txt"
input = readdlm(inp_path);

function find_increasing(input)
    increase_count = sum(diff(input,dims=1).>0)
    return increase_count
end

function find_sliding_increase(input)
    slide_sum =[];
    for n in 1:length(input)-2
        temp_sum = input[n]+input[n+1]+input[n+2];
        append!(slide_sum,temp_sum);
    end
    return slide_sum;
end

sol1 = find_increasing(input)
println("Solution to Part 1 is : ",sol1);
slide_sum = find_sliding_increase(input)
sol2 = find_increasing(slide_sum);
println("Solution to Part 2 is : ",sol2);