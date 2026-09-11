SELECT
    b.TRADE_ID AS trade_id,
    b.TRADE_DATE AS trade_date,
    b.TRADER_NAME AS trader_name,
    b.DESK AS desk,
    b.TICKER AS ticker,
    b.QUANTITY AS quantity_buy,
    b.PRICE AS price_buy,
    s.QUANTITY AS quantity_sell,
    s.PRICE AS price_sell
FROM {{ source('airbyte_csv_data', 'TRADING_BOOKS') }} b
JOIN {{ source('airbyte_csv_data', 'TRADING_BOOKS') }} s
    ON b.TRADER_NAME = s.TRADER_NAME
    AND b.TRADE_DATE = s.TRADE_DATE
WHERE b.TRADE_TYPE = 'BUY'
    AND s.TRADE_TYPE = 'SELL'
ORDER BY b.TRADE_ID
