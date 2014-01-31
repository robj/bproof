class Hotness
  
  EPOCH = Time.local(2012, 1, 1, 1, 1, 1).to_time

  # one week
  # score 10 = same as a new post a week later
  # scoree 100 , greater than > post with no votes 2 weeks later



  def self.epoch_seconds(t)
    (t.to_i - EPOCH.to_i).to_f
  end



  #http://bibwild.wordpress.com/2012/05/08/reddit-story-ranking-algorithm/
  #good: no cron required, displacement from an epoch
  def self.calculate(score,date,magnitude)

    
      magnitude_sec = 86400 if magnitude == :one_day
      magnitude_sec = 604800 if magnitude == :one_week
      magnitude_sec = 1209600 if magnitude == :two_weeks
      
      # otherwise 1 vote has no effect
      if score == 1
        score = 1.3
      end
      
      if score == -1
        score = -1.3
      end
            
      displacement = Math.log( [score.abs, 1].max,  10 )

      sign = if score > 0
        1
      elsif score < 0
        -1
      else
        0
      end
      
      
      #make votes pack double the punch (should just be changing magnitude?)
      displacement = displacement *2


      return (displacement * sign.to_f) + ( epoch_seconds(date) / magnitude_sec )
  end
  
  
  #not entirely important to implement?
  
  #http://www.evanmiller.org/how-not-to-sort-by-average-rating.html
  
  

end