import random
from datetime import datetime, timedelta

# Configuration
num_customers = 100
num_plants = 5
num_products = 150
large_customer_ids = set(random.sample(range(1, num_customers + 1), int(num_customers * 0.2)))

start_date = datetime.today() - timedelta(days=5 * 365)
end_date = datetime.today()

# Generate list of working days
working_days = [
    start_date + timedelta(days=i)
    for i in range((end_date - start_date).days + 1)
    if (start_date + timedelta(days=i)).weekday() < 5
]

sales_orders = []
for workday in working_days:
    order_count = random.randint(25, 50)
    for _ in range(order_count):
        customer_id = random.randint(1, num_customers)
        product_id = random.randint(1, num_products)
        plant_id = random.randint(1, num_plants)
        order_date = workday.date()
        delivery_date = (workday + timedelta(days=random.randint(1, 10))).date()
        order_volume = round(random.uniform(500, 8000) if customer_id in large_customer_ids else random.uniform(50, 2000), 2)

        sales_orders.append(
            f"({customer_id}, '{order_date}', '{delivery_date}', {product_id}, {plant_id}, {order_volume})"
        )

# Write to SQL file
with open("insert_salesorders_5yrs.sql", "w") as f:
    f.write("INSERT INTO SalesOrders (CustomerID, OrderCreationDate, DeliveryDate, ProductID, PlantID, OrderVolume)\nVALUES\n")
    f.write(",\n".join(sales_orders))
    f.write(";")

print("✅ SQL file 'insert_salesorders_5yrs.sql' generated successfully.")
