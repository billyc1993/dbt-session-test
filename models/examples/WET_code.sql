{% set field_list = 
[
    'one'
    , 'two'
    , 'three'
    , 'four'
    , 'five'
    , 'six'
    , 'seven'
    , 'eight'
    , 'nine'
    , 'ten'
]
%}
WITH old AS (
    select
        CASE 
            when example = 'one' THEN one_time
            WHEN example = 'two' THEN two_time
            WHEN example = 'three' THEN three_time
            WHEN example = 'four' THEN four_time
            WHEN example = 'five' THEN five_time
            WHEN example = 'six' THEN six_time
            WHEN example = 'seven' THEN seven_time
            WHEN example = 'eight' THEN eight_time
            WHEN example = 'nine' THEN nine_time
            WHEN example = 'ten' THEN ten_time
        END AS times
)

, new AS (
    select
        CASE
        {% for field in field_list %}
         WHEN example = {{ field }} THEN {{field}}_time
         {% endfor %}
)

select *
FROM new