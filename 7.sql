CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    price NUMERIC
);

CREATE TABLE order_products (
    order_id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(product_id),
    quantity INTEGER
);
INSERT INTO products (product_name, price) VALUES
('Product1', 10.50),
('Product2', 15.75),
('Product3', 20.00);

INSERT INTO order_products (product_id, quantity) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 4),
(3, 2);

CREATE OR REPLACE FUNCTION calculate_total_revenue(product_id INT)
RETURNS NUMERIC
AS $$
DECLARE
    total_revenue NUMERIC := 0;
BEGIN
    SELECT SUM(op.quantity * p.price) INTO total_revenue
    FROM order_products op
    JOIN products p ON op.product_id = p.product_id
    WHERE op.product_id = calculate_total_revenue.product_id;

    RETURN COALESCE(total_revenue, 0);
END;
LANGUAGE plpgsql
$$;
