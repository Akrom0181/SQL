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
INSERT INTO orders (amount) VALUES (0), (0), (0);

INSERT INTO order_products (order_id, product_id, quantity, price) VALUES
(1, 1, 2, 10), 
(1, 2, 1, 20), 
(2, 3, 3, 15); 


CREATE OR REPLACE FUNCTION update_order_amount()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE orders
    SET amount = (
        SELECT SUM(op.quantity * op.price)
        FROM order_products op
        WHERE op.order_id = NEW.order_id
    )
    WHERE id = NEW.order_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_order_amount_trigger
AFTER INSERT ON order_products
FOR EACH ROW
EXECUTE FUNCTION update_order_amount();
