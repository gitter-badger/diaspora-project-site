module Planet
  module Models
    class Entry < ActiveRecord::Base
      belongs_to :feed
      validates_presence_of :entry_id, :feed, :title, :body, :url
      validates_uniqueness_of :entry_id

      def sanitized_body
        Sanitize.fragment(self.body, Sanitize::Config.merge(
          Sanitize::Config::BASIC,
          :elements => Sanitize::Config::BASIC[:elements] + %w[img table],
          :attributes => {'img' => %w[alt src title style]},
          :css => Sanitize::Config::RELAXED[:css]
        ))
      end
    end
  end
end
