module SalesHelper

  #pass in the result of the class method inside sale.rb
def active_sale?
  Sale.active.any?
end


end