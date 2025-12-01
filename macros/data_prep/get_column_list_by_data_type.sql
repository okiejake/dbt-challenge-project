{%- macro get_column_list_by_data_type(table,data_type_group,dbt_source='info_schema__source_mirror') -%}

{%- if data_type_group == 'time' -%}

    {%- set data_types = [
        "datetime"
        ,"time"
        ,"timestamp"
        ,"timestamp_ltz"
        ,"timestamp_ntz"
        ,"timestamp_tz"
        ]
    -%}

{%- elif data_type_group == 'date' -%}

    {%- set data_types = [
        "date"
        ]
    -%}

{%- else -%}

    {%- set data_types = [
        "array"
        ,"bigint"
        ,"binary"
        ,"boolean"
        ,"byteint"
        ,"char"
        ,"character"
        ,"decimal"
        ,"double"
        ,"doubleprecision"
        ,"float"
        ,"float4"
        ,"float8"
        ,"geography"
        ,"geometry"
        ,"int"
        ,"integer"
        ,"number"
        ,"numeric"
        ,"object"
        ,"real"
        ,"smallint"
        ,"string"
        ,"text"
        ,"tinyint"
        ,"varbinary"
        ,"varchar"
        ,"variant"
        ,"vector"
        ]
    -%}

{%- endif -%}

{%- set sql_statement -%}
with
    source_columns as (select * from {{ source(dbt_source,'columns') }})

    , source_columns__filtered as (
        select
            array_to_string(array_agg(distinct lower(column_name)) within group (order by lower(column_name)),',') as column_list
        from source_columns
        where
            lower(table_name) = '{{ table }}'
            and lower(column_name) not in (
                'id'
                ,'_fivetran_synced'
                ,'_fivetran_start'
                ,'_fivetran_end'
                ,'_fivetran_active'
                ,'_fivetran_deleted'
            )
            and lower(data_type) in (
            {%- for data_type in data_types -%}
                {%- if not loop.first  -%} 
                    , 
                {%- endif -%}
                '{{ data_type }}'
            {%- endfor -%}
            )
        )

select * from source_columns__filtered
{%- endset -%}

{%- set columns = dbt_utils.get_single_value(sql_statement) -%}

{{- columns -}}

{%- endmacro -%}
