module ProspectsHelper

  def get_age(birth_year)
    if !birth_year.nil?
      birth_year= (Time.now.year - birth_year )
    end
    return birth_year  
  end

end