class Sale < ActiveRecord::Base

  #Creating AR Scope - making it really easy to query sales
  #checks to see if there are any active sales in the database uses
  #placeholders '?' and then we provide the two dynamic values to the where clause after the comma as the two values we want
def self.active
  where("sales.starts_on <= ? AND sales.ends_on >= ?", 
  Date.current, Date.current)
end

# these methods are now available in our views
  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  def active?
    !upcoming? && !finished?
  end

end
