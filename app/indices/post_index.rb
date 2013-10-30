ThinkingSphinx::Index.define :post, :with => :active_record, :delta => true do
  indexes title
  indexes body
  indexes created_at, sortable: true
end