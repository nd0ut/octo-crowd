ThinkingSphinx::Index.define :post, :with => :active_record, :delta => true do
  indexes title
  indexes body
end