with raw_data as (
    
    select * from {{ source('esci_raw', 'shopping_queries_sources') }}
),

cleaned as (
    select
        -- ID temizliği
        cast(query_id as string) as query_id,
        
        -- ARTIK HATA VERMEZ:
        -- Çünkü tablonun adı 'raw_data', sütunun adı 'source'. Karışıklık bitti.
        coalesce(source, 'Unknown') as device_source

    from raw_data
)

select * from cleaned