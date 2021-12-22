file = open("input.txt")
lines = readlines(file)

ChitonDensity = rotl90(reverse(parse.(Int,reduce(hcat,split.(lines,""))),dims=2))

function FindPath(ChitonDensity)
    updated_map = [ChitonDensity 20 .* ones(Int,size(ChitonDensity,1),1)]
    updated_map = [updated_map;20 .* ones(Int,1,size(updated_map,2))]
    cost_map = zeros(Int,size(ChitonDensity))
    for i in 1:size(updated_map,1)-1
        for j in 1:size(updated_map,2)-1
            cost_map[i,j] = min(updated_map[i,j+1],updated_map[i+1,j])
        end
    end

    path_risk_map = cost_map .* ChitonDensity

    destination_flag = 0
    x_pos = 1
    y_pos = 1
    risk_level = 0
    while(destination_flag == 0)
        if (x_pos == size(ChitonDensity,1))
            y_pos+=1
            risk_level += ChitonDensity[x_pos,y_pos]
        elseif (y_pos == size(ChitonDensity,2))
            x_pos+=1
            risk_level += ChitonDensity[x_pos,y_pos]
        else
            if (path_risk_map[x_pos+1,y_pos] < path_risk_map[x_pos,y_pos+1])
                x_pos += 1
                risk_level += ChitonDensity[x_pos,y_pos]
            elseif (path_risk_map[x_pos+1,y_pos] > path_risk_map[x_pos,y_pos+1])
                y_pos += 1
                risk_level += ChitonDensity[x_pos,y_pos]
            else
                if (x_pos < size(ChitonDensity,1)-2 && y_pos < size(ChitonDensity,2)-2)
                    if ChitonDensity[x_pos+3,y_pos] < ChitonDensity[x_pos,y_pos+3]
                        risk_level += ChitonDensity[x_pos+1,y_pos] + ChitonDensity[x_pos+2,y_pos] + ChitonDensity[x_pos+3,y_pos]
                        x_pos+=3
                    elseif ChitonDensity[x_pos+3,y_pos] > ChitonDensity[x_pos,y_pos+3]
                        risk_level += ChitonDensity[x_pos,y_pos+1] + ChitonDensity[x_pos,y_pos+2] + ChitonDensity[x_pos,y_pos+3]
                        y_pos+=3
                    end
                    # Not considering alternate path
                else
                    if (x_pos == size(ChitonDensity,1)-1)
                        if ChitonDensity[x_pos+1,y_pos+1] < ChitonDensity[x_pos,y_pos+2]
                            x_pos+=1
                            risk_level += ChitonDensity[x_pos,y_pos]
                            y_pos+=1
                            risk_level += ChitonDensity[x_pos,y_pos]
                        else
                            risk_level += ChitonDensity[x_pos,y_pos+1] + ChitonDensity[x_pos,y_pos+2]
                            y_pos+=2
                        end
                    elseif (y_pos == size(ChitonDensity,2)-1)
                        if ChitonDensity[x_pos+1,y_pos+1] < ChitonDensity[x_pos+2,y_pos]
                            x_pos+=1
                            risk_level += ChitonDensity[x_pos,y_pos]
                            y_pos+=1
                            risk_level += ChitonDensity[x_pos,y_pos]
                        else
                            risk_level += ChitonDensity[x_pos+1,y_pos] + ChitonDensity[x_pos+2,y_pos]
                            x_pos+=2
                        end
                    end
                end

                # else
                #     if (path_risk_map[x_pos+2,y_pos] < path_risk_map[x_pos,y_pos+2])
                #         risk_level += ChitonDensity[x_pos+1,y_pos] + ChitonDensity[x_pos+2,y_pos]
                #         x_pos+=2
                #     elseif (path_risk_map[x_pos+2,y_pos] > path_risk_map[x_pos,y_pos+2])
                #         risk_level += ChitonDensity[x_pos,y_pos+1] + ChitonDensity[x_pos,y_pos+2]
                #         y_pos += 2
                #     else
                #         # println(x_pos)
                #         # println(y_pos)
                #         sleep(0.5)
                #     end
                # end
            end
        end
        if x_pos == size(ChitonDensity,1) && y_pos == size(ChitonDensity,2)
            destination_flag = 1
        end
    end
    return risk_level
end

sol1 = FindPath(ChitonDensity)