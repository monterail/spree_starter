FactoryBot.define do
  factory :vendor, class: Spree::Vendor do
    name            { 'Birmingham_vendor_1' }
    state           { 'pending' }
    slug            { 'vendor-birmingham' }
    about_us        { '41-77 Victoria Rd, Birmingham B17 9RU' }
    commision_rate  { '5' }
    priority        { '8' }
    latitude        { rand(-90.0..90)  }
    longitude       { rand(-180.0..180.0) }
  end
end
