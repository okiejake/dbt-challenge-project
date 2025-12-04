{% test check_snapshot_dates(model) %}

with base as (
    select
        id,
        valid_from,
        valid_to
    from {{ model }}
),
    dups as (
        SELECT
            a.id,
            a.valid_from AS a_from,
            a.valid_from AS b_from,
            a.valid_to   AS a_to,
            a.valid_to   AS b_to,
            'duplicate' AS issue_type,
            cast(count(1) as varchar) as dup_count
        FROM base a
        group by all
        having count(1) > 1
    ),
    overlap AS (
        SELECT
            a.id,
            a.valid_from AS a_from,
            b.valid_from AS b_from,
            a.valid_to   AS a_to,
            b.valid_to   AS b_to,
            'overlap' AS issue_type,
            null
        FROM base a
        INNER JOIN base b
            ON a.id = b.id
            AND a.valid_from <= b.valid_to
            AND b.valid_from <= a.valid_to
            AND (a.valid_from, a.valid_to) <> (b.valid_from, b.valid_to)
    ),
    unioned AS (
        SELECT * FROM dups
        UNION ALL
        SELECT * FROM overlap
    )
    SELECT * FROM unioned
    order by id, a_from, issue_type
{% endtest %}