class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    # boats = Boat.all
    # boats[0..4]
    all.limit(5)

  end

  def self.dinghy
    # boats = Boat.all
    # boats.where("length < 20")
    where("length < 20")
  end

  def self.ship
    # boats = Boat.all
    # boats.where("length >= 20")
    where("length >= 20")
  end

  def self.last_three_alphabetically
    # boats = Boat.all
    # boats.all.order(name: :desc).limit(3)
    all.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    # boats = Boat.all
    # boats.where(captain_id: nil)
    where(captain_id: nil)
  end

  def self.sailboats
    # boats = Boat.all
    # boats.includes(:classifications).where(classifications: { name: 'Sailboat'})
    includes(:classifications).where(classifications: { name: 'Sailboat' })
  end

  def self.with_three_classifications
    # This is really complex! It's not common to write code like this
    # regularly. Just know that we can get this out of the database in
    # milliseconds whereas it would take whole seconds for Ruby to do the same.
    # boats = Boat.all
    # boats.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
    # #
    joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.non_sailboats
    where("id NOT IN (?)", self.sailboats.pluck(:id))
    # boats = Boat.all
    # boats.where('id NOT in (?)', boats.sailboats,pluck(:id))
  end

  def self.longest
    order('length DESC').first
    # boats = Boat.all
    # boats.order('length DESC').first 
  end
end
