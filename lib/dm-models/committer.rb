class Committer
  include DataMapper::Resource

  property :id,   Serial
  property :name, String, :length => 255

  has n, :contributions
  has n, :projects,         :through => :contribution
  has n, :cocontributions,  :through => :projects# , Author.papers.authors.id.not => Author.id
  has n, :cocontributor,    :through => :cocontributions

  # @return [Integer]
  #   degrees of separation from Paul Erdös
  def dkubb_number(limit=99)
    (0..limit).find { |depth| self.my_dkubb_number?(depth) }
  end

  # @return [Boolean]
  #   is +depth+ the degrees of separation between receiver and Paul Erdös?
  def my_dkubb_number?(depth)
    # produces well defined query, with a repeating relation
    # where depth defines the number of repetitions

    committers_at_depth = Committer.all(:name => "Dan Kubb")
    return true if committers_at_depth.include?(self)

    depth.times { |i| committers_at_depth = committers_at_depth.coauthors }

    committers_at_depth.collaborators.include?(self) # return true or false
  end
end
