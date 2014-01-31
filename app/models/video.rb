class Video

	include Mongoid::Document
	include Mongoid::Timestamps

	before_save :cache_hotness
	before_create :transcode

	symbolize :encoded_state, :in => [:queued, :encoding, :failed, :finished], :default => :queued, :allow_blank => false, :scopes => true, :i18n => false




	def cache_hotness

		weighted_score = (1*self.score + 2*self.favorite_count)
		self.hotness = Hotness.calculate(weighted_score, self.created_at, :one_week)

	end


	def transcode
		 Transcode.perform_async(self.id.to_s)
	end



end

