This repository is excerpts of functionality pulled out of a Ruby on Rails App I have architected. It aims to show the use interesting features and best practices in Rails Development.

Here exists a Video resource for an app that is both a website and Application API endpoint.

To reduce maintenence both the website and Application use the API. The website uses Backbone Models to achive this. The API is versioned, following RESTful principles.


app/routes.rb

- versioned API, only RESTful actions

app/models/video.rb

- Uses Mongoid
- 'symbolize' for enumeration
- Hotness (ie. Reddit hotness algoirthm) extracted out into own class /lib/hotness.rb
- Sidekiq after_create to async kick off a Transcode worker


app/controllers/v1/base_controller.rb

- Shared code for adding Links Headers for Pagination (http://tools.ietf.org/search/rfc5988)
- WrapParams as non-envloped params sent to controller 
 ( as per http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api)


app/controllers/v1/videos_controller.rb

- index action builds up Mongoid criteria from filtering/sorting paramaters
- update/destroy actions use authorizer ( 'authority' gem)
- defult render: json uses serializer (ActiveModelSerializers) - app/serializers/video_serializer.rb


app/videos/index.html.erb

- bootstrap elements to create filter/sort menus


app/javascipts/video.js


- uses BackbonePageableCollection to create very simple RESTful infinitely paging videos
- BackbonePageableCollection picks up pagination data from Link header



Design problems that existing before refactor.


- Non DRY controller code replication for web and API  (controllers/video & v1/controllers.video)
- Pagination felt much more hacky on web side.

ie.

infinite scrolling triggered view/videos/index.js.erb which has logic:

if first page or search params change

-delete grid container, render grid container partial + first page

if not first page

-append grid page








