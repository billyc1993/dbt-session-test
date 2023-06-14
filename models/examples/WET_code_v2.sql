{% set field_list = 
[
    ['one', 1]
    , ['two', 2]
    , ['three', 3]
    , ['four', 4]
    , ['five', 5]
    , ['six', 6]
    , ['seven', 7]
    , ['eight', 8]
    , ['nine', 9]
    , ['ten', 10]
    , ['zero', 0]
]
%}
WITH old AS (
    select
            SUM(CASE WHEN example = 'one' THEN 1 END) AS one_time
            SUM(CASE WHEN example = 'two' THEN 2 END) AS two_time
            SUM(CASE WHEN example = 'three' THEN 3 END) AS three_time
            SUM(CASE WHEN example = 'four' THEN 4 END) AS four_time
            SUM(CASE WHEN example = 'five' THEN 5 END) AS five_time
            SUM(CASE WHEN example = 'six' THEN 6 END) AS six_time
            SUM(CASE WHEN example = 'seven' THEN 7 END) AS seven_time
            SUM(CASE WHEN example = 'eight' THEN 8 END) AS eight_time
            SUM(CASE WHEN example = 'nine' THEN 9 END) AS nine_time
            SUM(CASE WHEN example = 'ten' THEN 10 END) AS ten_time
            SUM(CASE WHEN COALESCE(example, 'zero') = 'zero') THEN 0 END) AS zero_time
)

, new AS (
    select
        CASE
        {% for field in field_list %}
        {% set criteria = '' %}
        {% if field == 'zero' %}
            {% set criteria = "COALESCE(example, 'zero') = " + field[0] %}
        {% else %}
            {% set criteria = "example = " + field[0] %}
        {% endif %}

         WHEN {{ criteria }} THEN {{field[1]}} AS {{field[0]}}_time
         {% endfor %}
)

select *
FROM new