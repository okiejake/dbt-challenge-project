version: 2

snapshots:
  - name: erp__rexel_gexpro__product__snapshot
    relation: ref('erp__rexel_gexpro__product__standardized')
    description: "A dbt Snapshot of Products data from Rexel/GexPro, which tracks the history of changes to the attributes of each product."
    config:
      tags:
        - snapshots
        - rexel_gexpro
      database: data_prep
      schema: erp__rexel_gexpro__snapshot
      strategy: timestamp
      unique_key: id
      hard_deletes: invalidate
      updated_at: updt
      dbt_valid_to_current: convert_timezone('America/New_York',to_timestamp('9999-12-31 23:59:59.999'))
      snapshot_meta_column_names:
        dbt_scd_id: snapshot_key
        dbt_updated_at: record_snapshot_at
        dbt_valid_from: valid_from
        dbt_valid_to: valid_to
    columns:
      - name: id
      - name: name
      - name: desc_txt_280
