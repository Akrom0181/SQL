CREATE OR REPLACE FUNCTION order_delete()
RETURNS TRIGGER AS $$
BEGIN

    IF EXISTS (SELECT 1 FROM order_products WHERE order_id = OLD.id) THEN
        RAISE EXCEPTION 'Cant delete order with ID', OLD.id;
    END IF;
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER order_delete_trigger
BEFORE DELETE ON orders
FOR EACH ROW
EXECUTE FUNCTION order_delete();
