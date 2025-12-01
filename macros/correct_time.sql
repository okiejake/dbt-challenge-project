{%- macro correct_time(column_name,timezone='America/New_York') -%}

convert_timezone('{{timezone}}', {{ column_name}}) as {{ column_name }}

{%- endmacro -%}
