CREATE table brands (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar(25),
    has_stock boolean,
    rate int
);
CREATE table brand_products(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name varchar(50),
    brand_id UUID REFERENCES brands(id),
    price int,
    country varchar(50)
);                                                                            

   