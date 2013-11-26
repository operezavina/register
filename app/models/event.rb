class Event < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  validates :name, presence: true, length: { maximum: 50 }
  #attr_accessible :name, :start_time, :end_time
  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |event|
        csv << event.attributes.values_at(*column_names)
      end
    end
  end
end
