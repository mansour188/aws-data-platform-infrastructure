Glue Catalog
│
└── data_platform
       │
       └── bronze_events
              │
              ├── event_id       string
              ├── user_id        string
              ├── event_type     string
              ├── product_id     string
              ├── amount         double
              └── currency       string
                         │
                         │ points to
                         ▼
                s3://data-platform-bronze/events/


Notice: no data is being copied by Glue Catalog.

The table simply says:

"When somebody asks for bronze_events, look at this S3 location and interpret the files using this schema."



## Troubleshooting

### Floci Glue ID Error

Sometimes Floci creates the Glue resource successfully, but Terraform receives an incomplete ID such as:

```text
:data_platform
:data_platform:bronze_events
```

instead of:

```text
000000000000:data_platform
000000000000:data_platform:bronze_events
```

Verify the resource exists first:

```bash
aws glue get-database --name data_platform
aws glue get-table --database-name data_platform --name bronze_events
```

If it exists, repair Terraform state:

```bash
terraform state rm module.glue_catalog.aws_glue_catalog_database.this
terraform import module.glue_catalog.aws_glue_catalog_database.this "000000000000:data_platform"
```

For the table:

```bash
terraform state rm module.glue_catalog.aws_glue_catalog_table.bronze_events
terraform import module.glue_catalog.aws_glue_catalog_table.bronze_events "000000000000:data_platform:bronze_events"
```

Then verify:

```bash
terraform plan
```

Expected:

```text
Plan: 0 to add, 0 to change, 0 to destroy.
```

> `terraform state rm` only removes Terraform's state entry. It does **not** delete the Floci resource.
