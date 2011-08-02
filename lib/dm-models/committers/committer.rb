module Committers
  class Committer
    include DataMapper::Resource

    property :id,   Serial
    property :name, String, :length => 255

    has n, :contributions
    has n, :projects,         :through => :contributions
    has n, :cocontributions,  :through => :projects# , Author.papers.authors.id.not => Author.id
    has n, :cocontributors,   :through => :cocontributions

    # @return [Integer]
    #   degrees of separation from Paul Erdös
    def degrees_of_separation_from(person,limit=99)
      (0..limit).find { |limit| self.separated_by?(person, limit) }
    end

    # @return [Boolean]
    #   is +depth+ the degrees of separation between receiver and Paul Erdös?
    def separated_by?(person, distance)
      # produces well defined query, with a repeating relation
      # where depth defines the number of repetitions

      committers_at_distance = person
      return true if committers_at_distance.include?(self)

      distance.times { |i| committers_at_distance = committers_at_distance.cocontributors("id.not" => self.id) }

      committers_at_distance.collaborators.include?(self) # return true or false
    end
  end
end
