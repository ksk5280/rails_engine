def create_merchant(name)
  Merchant.create(name: name)
end

def create_customer(first_name, last_name)
  Customer.create(first_name: first_name, last_name: last_name)
end

def create_item(name, desc, price)
  Item.create(name: name, description: desc, unit_price: price)
end

def create_items
  Item.create(
    name: "Shirt",
    description: "Shirt description",
    unit_price: 50,
  )
  Item.create(
    name: "Pants",
    description: "Pants description",
    unit_price: 75,
  )
  Item.create(
    name: "Socks",
    description: "Socks description",
    unit_price: 25,
  )
end

def create_invoice(customer_id, merchant_id, status)
  Invoice.create(
    customer_id: customer_id,
    merchant_id: merchant_id,
    status: status)
end

def create_invoice_item(item_id, invoice_id, quantity, price)
  InvoiceItem.create(
    item_id: item_id,
    invoice_id: invoice_id,
    quantity: quantity,
    unit_price: price)
end

def create_transaction(result, invoice_id, credit_card_number)
  Transaction.create(
    result: result,
    invoice_id: invoice_id,
    credit_card_number: credit_card_number)
end

def create_all
  item1 = create_item("Shirt", "Shirt description", 50)
  item2 = create_item("Pants", "Pants description", 75)
  item3 = create_item("Socks", "Socks description", 100)
  cust1 = create_customer("Joey", "Ondricka")
  cust2 = create_customer("Cecilia", "Osinski")
  cust3 = create_customer("Mariah", "Toy")
  merc1 = create_merchant("Schroeder-Jerde")
  merc2 = create_merchant("Klein, Rempel and Jones")
  inv1  = create_invoice(cust1.id, merc1.id, "pending")
  inv2  = create_invoice(cust2.id, merc2.id, "shipped")
  inv3  = create_invoice(cust3.id, merc2.id, "shipped")
  invitem1 = create_invoice_item(item1.id, inv1.id, 1, 100)
  invitem2 = create_invoice_item(item2.id, inv2.id, 2, 200)
  invitem3 = create_invoice_item(item3.id, inv3.id, 3, 100)
  trans1 = create_transaction("failed", inv1.id, "1111111111111111")
  trans2 = create_transaction("success", inv1.id, "2222222222222222")
  trans3 = create_transaction("success", inv2.id, "3333333333333333")
end
