class VideoAuthorizer < ApplicationAuthorizer


  	 def updatable_by?(user)
	 	  resource.user == user || user.admin?
	 end

	 def deletable_by?(user)
	 	  resource.user == user || user.admin?
  	 end



end

