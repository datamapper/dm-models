__END__

Author.create(
  :name => "Paul Erdös"
)

Author.first.erdos_number # => nil, or some positive integer

SELECT id
FROM authors
JOIN authorships ON author.id = authorships.author_id
JOIN papers ON authorships.paper_id = paper.id
JOIN authorships AS coauthorships ON coauthorships.paper_id = paper.id
JOIN authors AS coauthors1 ON coauthorships.author_id = coauthors1.id
JOIN authorships AS coauthorships2 ON coauthorships2.author_id = coauthors1.id
JOIN papers AS coauthored_papers ON coauthorships2.paper_id = coauthored_papers.id
JOIN authorships AS coauthorships3 ON coauthorships3.paper_id = coauthored_papers.id
JOIN authors AS coauthors2 ON coauthorships3.author_id = coauthors2.id

// relations: [authors, authorships, papers, coauthorships, coauthors]

Author relation header: [:id, :name]
Authorship relation header: [:author_id, :paper_id]
Paper relation header: [:id, :title, :abstract]

Author.authorships
authors.id = authorships_author_id # example naming by relationship(s) from source model
authors.id IN authorships_papers_coauthorships_coauthors_id # NO, too verbose
coauthorship1 => coauthorship2 # yes, not too verbose, unique, and still descriptive
