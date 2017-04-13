class Url < ActiveRecord::Base
	# This is Sinatra! Remember to create a migration!
	before_create :shortener, :counter, :is_url_valid
	validates :long_url, :presence => true
	validate :is_url_valid
	#to shorten long url to short version, randomize 6 characters.
	def shortener
		characters = [*"0".."9", *"A".."Z", *"a".."z"]

		@short_url = (0..6).map{characters.sample}.join
		self.short_url = @short_url
	end

	#url click counter
	def counter
		self.click_count = 0
	end

	def is_url_valid
		unless self.long_url.starts_with?("http://", "https://")
			errors.add(:long_url, "invalid format")
		end
	end
end

