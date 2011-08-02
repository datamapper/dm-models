module Committers
  class Contribution
    belongs_to :committer
    belongs_to :project
  end
end
