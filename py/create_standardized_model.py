import yaml
from pathlib import Path

# -----------------------------------------------------
# INPUTS
# -----------------------------------------------------
YAML_FILE = "sources/_source__erp__capitol_light.yml"
OUTPUT_SQL_FILE = "models/data_prep/erp__capitol_light__standardized/erp__capitol_light__product__standardized.sql"

# Which table you want to generate a model for
TARGET_SOURCE = "erp__capitol_light"
TARGET_TABLE = "product_attr_01"

# -----------------------------------------------------
# LOAD THE YAML
# -----------------------------------------------------
with open(YAML_FILE, "r") as f:
    data = yaml.safe_load(f)

sources = data.get("sources", [])

# -----------------------------------------------------
# FIND THE RIGHT SOURCE + TABLE
# -----------------------------------------------------
columns = None
for src in sources:
    if src.get("name") == TARGET_SOURCE:
        for tbl in src.get("tables", []):
            if tbl.get("name") == TARGET_TABLE:
                # Extract column names
                columns = [col["name"] for col in tbl.get("columns", [])]

if not columns:
    raise ValueError("Could not find matching source/table in YAML.")

# -----------------------------------------------------
# BUILD THE SQL MODEL CONTENT
# -----------------------------------------------------
sql_lines = [
    "{% set source_name = '" + TARGET_SOURCE + "' %}",
    "{% set table_name = '" + TARGET_TABLE + "' %}",
    "",
    "select",
]

# Add columns with commas
for i, col in enumerate(columns):
    comma = "," if i < len(columns) - 1 else ""
    sql_lines.append(f"    {col}{comma}")

sql_lines.append("")
sql_lines.append("from {{ source(source_name, table_name) }}")

sql_content = "\n".join(sql_lines)

# -----------------------------------------------------
# WRITE THE SQL FILE
# -----------------------------------------------------
with open(OUTPUT_SQL_FILE, "w") as f:
    f.write(sql_content)

print(f"Generated: {OUTPUT_SQL_FILE}")