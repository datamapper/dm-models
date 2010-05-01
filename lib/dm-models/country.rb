class Country
  include DataMapper::Resource

  property :id,          Integer, :min => 1, :max => 999, :key => true
  property :name,        String,  :length => 1..50, :required => true, :unique => true, :unique_index => true
  property :code_alpha2, String,  :length => 2,     :required => true, :unique => true, :unique_index => true, :auto_validation => false
  property :code_alpha3, String,  :length => 3,     :required => true, :unique => true, :unique_index => true, :auto_validation => false

  validates_presence_of :code_alpha2, :code_alpha3

  validates_length_of :code_alpha2, :is => 2, :allow_nil => true
  validates_length_of :code_alpha3, :is => 3, :allow_nil => true

  validates_format_of :code_alpha2, :code_alpha3, :with => /\A[A-Z]+\z/
end
