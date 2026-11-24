module DestinationsHelper
  def flag_emoji(country_code)
    return "🌍" if country_code.blank? || country_code.length != 2

    country_code.upcase.chars.map { |char| (char.ord + 127397).chr(Encoding::UTF_8) }.join
  rescue StandardError
    "🌍"
  end
end
