Zabka_Winogrady = Spree::Vendor.create(
    name: "Zabka Winogrady",
    about_us: "Winogrady 61",
    postcode: "61-659"
)

Zabka_Gorczyn = Spree::Vendor.create(
    name: "Zabka Gorczyn",
    about_us: "Głogowska 173a",
    postcode: "60-126"
)

Zabka_Centrum = Spree::Vendor.create(
    name: "Zabka Centrum",
    about_us: "Wrocławska 23",
    postcode: "61-838"
)

Zabka_Junikowo = Spree::Vendor.create(
    name: "Zabka Junikowo",
    about_us: "Malwowa 103a",
    postcode: "60-175"
)

product_1 = Spree::Product.create(
    name: "shirt",
    description: "Lorem Ipsum bla bla bla",
    tax_category_id: 1,
    shipping_category_id: 1,
    vendor_id: 1,
    price: 25
)

product_2 = Spree::Product.create(
    name: "shirt 2",
    description: "Lorem Ipsum bla bla bla",
    tax_category_id: 1,
    shipping_category_id: 1,
    vendor_id: 2,
    price: 25
)

product_3 = Spree::Product.create(
    name: "shirt 3",
    description: "Lorem Ipsum bla bla bla",
    tax_category_id: 1,
    shipping_category_id: 1,
    vendor_id: 1,
    price: 25
)

product_4 = Spree::Product.create(
    name: "shirt 4",
    description: "Lorem Ipsum bla bla bla",
    tax_category_id: 1,
    shipping_category_id: 1,
    vendor_id: 3,
    price: 25
)

product_5 = Spree::Product.create(
    name: "shirt 5",
    description: "Lorem Ipsum bla bla bla",
    tax_category_id: 1,
    shipping_category_id: 1,
    vendor_id: 2,
    price: 25
)

product_6 = Spree::Product.create(
    name: "shirt 6",
    description: "Lorem Ipsum bla bla bla",
    tax_category_id: 1,
    shipping_category_id: 1,
    vendor_id: 1,
    price: 25
)

