{%- macro generate_standardized_model_query(table,natural_key) -%}

    select
        {{ get_column_list_for_standardized_model(table,natural_key) }}
    from {{table}}

{%- endmacro -%}
