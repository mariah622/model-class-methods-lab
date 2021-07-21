class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    # # captains = Captain.all
    # captains.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
     includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    # captains = Captain.all
    # captains. includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
    includes(boats: :classifications).where(classifications: {name: "Sailboat"}).distinct
  end

  def self.motorboat_operators
    # captains = Captain.all
    # captains.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
    includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    # captains = Captain.all
    # captains. where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
    where("id IN (?)", self.sailors.pluck(:id) & self.motorboat_operators.pluck(:id))
  end

  def self.non_sailors
    # captains = Captain.all
    # captains.where.not("id IN (?)", self.sailors.pluck(:id))
    where.not("id IN (?)", self.sailors.pluck(:id))
  end

end
