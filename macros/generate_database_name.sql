{% macro generate_database_name(custom_database_name=none, node=none) -%}

    {%- set default_database = target.database -%}
    {%- if target.name == 'prd' or target.name == 'ci'  -%}

        {{ default_database }}

    {%- else -%}

        {{  custom_database_name | trim }}_dev

    {%- endif -%}

{%- endmacro %}