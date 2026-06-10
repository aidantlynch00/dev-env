function concat_tables(t1, t2)
    local result = {}

    -- copy t1 to result
    for k, v in pairs(t1) do
        result[k] = v
    end

    local offset = #result

    for k, v in pairs(t2) do
        -- numeric keys so offset based on t1 length
        if type(k) == "number" and k >= 1 and math.floor(k) == k then
            result[offset + k] = v
        else
            result[k] = v
        end
    end

    return result
end
