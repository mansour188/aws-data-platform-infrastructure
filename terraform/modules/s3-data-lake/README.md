                         FLoci
                           │
                           ▼
                     ┌───────────┐
                     │    S3     │
                     │ Data Lake │
                     └─────┬─────┘
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
            raw/        bronze/       silver/
              │            │            │
          30-day       processed      cleaned
          retention       data          data
                           │
                           ▼
                         gold/
                      analytics