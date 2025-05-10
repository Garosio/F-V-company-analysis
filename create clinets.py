import random
from faker import Faker

fake = Faker()

def clean_string(s):
    return s.replace("'", "''")


customers_clean = []
for i in range(100):
    name = clean_string(fake.name() if random.random() < 0.5 else fake.company())
    cust_type = "Business" if random.random() < 0.5 else "Consumer"
    email = clean_string(fake.email())
    phone = ''.join(filter(str.isdigit, fake.phone_number()))  # digits only
    address = clean_string(fake.address().replace('\n', ', '))
    customers_clean.append(f"('{name}', '{cust_type}', '{email}', '{phone}', '{address}')")

# Save to file
with open("customers.sql", "w") as f:
    f.write("INSERT INTO Customers (Name, CustomerType, Email, Phone, Address)\nVALUES\n")
    f.write(",\n".join(customers_clean))
    f.write(";")
