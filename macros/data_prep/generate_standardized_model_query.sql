{%- macro generate_standardized_model_query(table,natural_key,updated_at_col) -%}

    select
        {{ get_column_list_for_standardized_model(table,natural_key,updated_at_col) }}
    from {{table}}

{%- endmacro -%}
