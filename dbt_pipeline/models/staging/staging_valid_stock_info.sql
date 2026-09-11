SELECT
    s.TICKER,
    s.TRADE_DATE,
    sp.VARIABLE,
    sp.VALUE
FROM {{ ref('staging_valid_stock_tickers') }} s
JOIN {{ source('snowflake_public_data', 'STOCK_PRICE_TIMESERIES_PIT') }} sp
    ON s.TICKER = sp.TICKER AND s.TRADE_DATE = sp.DATE
WHERE sp.VARIABLE IN ('all-day_high', 'all-day_low')
