{%- macro get_column_list_for_standardized_model(table,natural_key) -%}

            {{natural_key}} as id
            {% set nontime_columns = get_column_list_by_data_type(table,'nontime') -%}
            {%- set nontime_columns_string = nontime_columns|string -%}
            {%- set nontime_column_list = nontime_columns_string.split(',') -%}
            {%- if nontime_column_list|length == 1 and nontime_columns_string != '' %}
                , {{ nontime_columns_string }}
            {% elif nontime_column_list|length > 1 %}
            {%- for column_name in nontime_column_list -%}
                , {{ column_name }}
            {% endfor -%}
            {%- endif -%}
            {%- set date_columns = get_column_list_by_data_type(table,'date') -%}
            {%- set date_columns_string = date_columns|string -%}
            {%- set date_column_list = date_columns_string.split(',') -%}
            {% if date_column_list|length == 1 and date_columns_string != '' -%}
               , {{ date_columns_string }}
            {% elif date_column_list|length > 1 %}
            {%- for column_name in date_column_list -%}
                , {{ column_name }}
            {% endfor -%}
            {%- endif -%}
            {%- set time_columns = get_column_list_by_data_type(table,'time') -%}
            {%- set time_columns_string = time_columns|string -%}
            {%- set time_column_list = time_columns_string.split(',') -%}
            {% if time_column_list|length == 1 and time_columns_string != '' -%}
               , {{ correct_time(time_columns_string) }}
            {% elif time_column_list|length > 1 %}
            {%- for column_name in time_column_list -%}
                , {{ correct_time(column_name) }}
            {% endfor -%}
            {%- endif -%}
            , convert_timezone('America/New_York', _fivetran_synced) as refreshed_at

{%- endmacro -%}
