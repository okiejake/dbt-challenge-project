version: 2

snapshots:
  - name: erp__capitol_light__product__snapshot
    relation: ref('erp__capitol_light_product__standardized')
    description: "A dbt Snapshot of Products data from Capitol Light, which tracks the history of changes to the attributes of each product."
    config:
      tags:
        - snapshots
        - capitol_light
      database: data_prep
      schema: erp__capitol_light__snapshot
      strategy: timestamp
      unique_key: id
      hard_deletes: invalidate
      updated_at: updated_at
      dbt_valid_to_current: convert_timezone('America/New_York',to_timestamp('9999-12-31 23:59:59.999'))
      snapshot_meta_column_names:
        dbt_scd_id: snapshot_key
        dbt_updated_at: record_snapshot_at
        dbt_valid_from: valid_from
        dbt_valid_to: valid_to
    columns:
      - name: id
      - name: product_attr_01__name
      - name: product_attr_01__desc
