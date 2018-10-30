module FindMethods

  def find_by_id(id)
    @all.find do |item|
      item.id == id
    end
  end

  def find_by_name(name)
    @all.find do |item|
      item.name.upcase == name.upcase
    end
  end

  def delete(id)
    @all.delete_if do |item|
      item.id == id
    end
  end

  def find_highest_id
     current_highest = @all.max_by do |element|
       element.id
     end
     current_highest.id
  end

end
