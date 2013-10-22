ThinkingSphinx::Index.define :post, :with => :active_record do
  indexes title
  indexes body
end