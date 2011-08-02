Committer.create(
  :name => "Dan Kubb"
)

Committer.first.erdos_number # => nil, or some positive integer

__END__

SELECT id
FROM committers
JOIN contributions ON committer.id = contributions.committer_id
JOIN projects ON contributions.project_id = project.id
JOIN contributions AS cocontributions ON cocontributions.project_id = project.id
JOIN committers AS cocommitters1 ON cocontributions.committer_id = cocommitters1.id
JOIN contributions AS cocontributions2 ON cocontributions2.committer_id = cocommitters1.id
JOIN projects AS cocontributed_projects ON cocontributions2.project_id = cocontributed_projects.id
JOIN contributions AS cocontributions3 ON cocontributions3.project_id = cocontributed_projects.id
JOIN committers AS cocommitters2 ON cocontributions3.committer_id = cocommitters2.id

// relations: [committers, contributions, projects, cocontributions, cocontributors]

Committer relation header: [:id, :name]
Contribution relation header: [:committer_id, :project_id]
Project relation header: [:id, :name, :description]

Committer.contributions
committers.id = contributions_committer_id # example naming by relationship(s) from source model
committers.id IN contributions_projects_cocontributions_cocommitters_id # NO, too verbose
contributions1 => contributions2 # yes, not too verbose, unique, and still descriptive
