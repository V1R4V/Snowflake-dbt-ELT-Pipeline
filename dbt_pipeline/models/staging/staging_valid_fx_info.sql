SELECT
    f.TICKER,
    f.TRADE_DATE,
    fx.VARIABLE_NAME,
    fx.VALUE AS exchange_rate
FROM {{ ref('staging_valid_fx_tickers') }} f
JOIN {{ source('snowflake_public_data', 'FX_RATES_TIMESERIES_PIT') }} fx
    ON f.TRADE_DATE = fx.DATE
WHERE fx.BASE_CURRENCY_ID IN ('EUR', 'GBP')
    AND fx.QUOTE_CURRENCY_ID = 'USD'
