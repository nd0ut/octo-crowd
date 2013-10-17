class CategoryDecorator < Draper::Decorator
  delegate_all

  def name
    begin
      I18n.t "draper.categories.#{object.name}", raise: I18n::MissingTranslationData
    rescue I18n::MissingTranslationData
      object.name + ' (translation missing)'
    end
  end

end
