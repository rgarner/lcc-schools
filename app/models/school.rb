class School < ActiveRecord::Base
  self.inheritance_column = :unused

  include PgSearch
  pg_search_scope :containing_text, against: {
    code: 'A',
    name: 'A',
    address1: 'A',
    address2: 'A',
    address3: 'A',
    postcode: 'B'
  }

  scope :phase, -> (phase) {
    where("schools.phase ~* ? OR schools.phase ~* 'through'", [phase])
  }

  scope :nearest_to, -> (point) {
    select("schools.*, ST_Distance(schools.centroid,'SRID=4326;POINT(#{point.lon} #{point.lat})'::geometry) AS distance").
    order("schools.centroid <->'SRID=4326;POINT(#{point.lon} #{point.lat})'::geometry")
  }

  scope :community, -> {
    where(type: 'Community')
  }

  scope :own_admissions_policy, -> {
    where.not(type: 'Community')
  }

  def address
    "#{address1} #{postcode}"
  end

  def community_admission_policy?
    type == 'Community'
  end

  def own_admission_policy?
    !community_admission_policy?
  end

  def to_param
    code
  end

  def contended?
    nearest.present?
  end

  def priority_stats?
    School.priorities.any? { |priority| (send priority).present? }
  end

  def sum_of_priorities
    return nil unless priority_stats?
    School.priorities.inject(0) do |sum, prop|
      value = send prop
      sum += value if value
      sum
    end
  end

  def age_range
    "#{from_age}-#{to_age}"
  end

  def self.priorities
    %i( priority1a priority1b priority2
         priority3 priority4 priority5  )
  end
end
