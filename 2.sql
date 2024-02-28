
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    amount NUMERIC
);

CREATE TABLE order_products (
    id SERIAL PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price NUMERIC,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

INSERT INTO orders (id, amount) VALUES
(1, 0), (2, 0), (3, 0);

INSERT INTO order_products (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 14), 
(1, 2, 1, 31), 
(2, 3, 3, 17); 


CREATE OR REPLACE FUNCTION calculate_total_price(order_id INT)
RETURNS NUMERIC AS $$
DECLARE
    total_price NUMERIC := 0;
BEGIN

    SELECT SUM(quantity * price) INTO total_price
    FROM order_products
    WHERE order_id = calculate_total_price.order_id;

    RETURN total_price;
END;
$$ LANGUAGE plpgsql;
