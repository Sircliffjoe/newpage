module PagesHelper
  def flag_emoji(country_code)
    return "" if country_code.blank?
    
    country_code = country_code.upcase
    country_code.split("").map { |char| (char.ord + 127397).chr }.join
  rescue
    "🌍"
  end
end
