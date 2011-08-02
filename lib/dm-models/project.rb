class Project
  property :id,           Serial
  property :name,         String
  property :description,  Text

  has n, :contributions
  has n, :committers, :through => :contributions
end
