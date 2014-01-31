class VideoSerializer < ActiveModel::Serializer

	attributes :id
	attributes :name

	attributes :hls_index_url

	attributes :thumbnail_url
	attributes :vtt_thumbnail_url

	attributes :lightbox_height
	attributes :lightbox_width
	attributes :widescreen?


end


