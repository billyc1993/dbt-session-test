{% set field_list = 
[
    ['one', 1, '_1_time']
    , ['two', 2, '_2_time']
    , ['three', 3, '_3_time']
    , ['four', 4, '_4_time']
    , ['five', 5, '_5_time']
    , ['six', 6, '_6_time']
    , ['seven', 7, '_7_time']
    , ['eight', 8, '_8_time']
    , ['nine', 9 , '_9_time']
    , ['ten', 10, '_10_time']
    , ['zero', 0, 'nothing_at_all']
]
%}
WITH old AS (
    select
            SUM(CASE WHEN example = 'one' THEN 1 END) AS _1_time
            SUM(CASE WHEN example = 'two' THEN 2 END) AS _2_time
            SUM(CASE WHEN example = 'three' THEN 3 END) AS _3_time
            SUM(CASE WHEN example = 'four' THEN 4 END) AS _4_time
            SUM(CASE WHEN example = 'five' THEN 5 END) AS 5_time
            SUM(CASE WHEN example = 'six' THEN 6 END) AS _6_time
            SUM(CASE WHEN example = 'seven' THEN 7 END) AS _7_time
            SUM(CASE WHEN example = 'eight' THEN 8 END) AS _8_time
            SUM(CASE WHEN example = 'nine' THEN 9 END) AS _9_time
            SUM(CASE WHEN example = 'ten' THEN 10 END) AS _10_time
            SUM(CASE WHEN COALESCE(example, 'zero') = 'zero' THEN 0 END) AS nothing_at_all
)

, new AS (
    select
        CASE
        {% for field in field_list %}
        {% set criteria = '' %}
        {% if field[0] == 'zero' %}
            {% set criteria = "COALESCE(example, 'zero') = " + field[0] %}
        {% else %}
            {% set criteria = "example = " + field[0] %}
        {% endif %}

         WHEN {{ criteria }} THEN {{field[1]}} AS {{field[2]}}
         {% endfor %}
)

select *
FROM new