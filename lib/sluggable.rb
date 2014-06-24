module Sluggable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug
    class_attribute :slug_col
  end 

  def generate_slug
    self.slug = slug_gen(slug_preprocess(self.send(self.class.slug_col.to_sym))) do |slug; item|
      item = self.class.find_by(slug: slug)
      item.nil? || item == self
    end
  end

  def slug_preprocess(str)
    str.strip().gsub(/\W/, '-').squeeze('-').downcase
  end

  def slug_gen(str)
    count = 0
    slug_str = str
    while true
      break if yield slug_str
      count += 1
      slug_str = str + "-#{count}"
    end
    slug_str
  end

  def to_param
    slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_col = col_name
    end
  end

end
