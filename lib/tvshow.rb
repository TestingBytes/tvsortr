class TVShow
  attr_reader :fileName, :name, :type, :episode, :season
  
  def initialize(fileName)
    @fileName = fileName 
    
    if @fileName =~ /(.+)(\d{4}).(\d{2}.\d{2})/
      @type = "Daily"
      @name,@season,@episode = $1,$2,$3
      
      @name     = @name.gsub("."," ").strip
      @season   = @season.gsub(/^0+/,"")
            
    elsif @fileName =~ /(.+)S(\d{2})E(\d{2})/
      @type = "Episodic"
      @name,@season,@episode = $1,$2,$3

      @name     = @name.gsub("."," ").strip
      @season   = @season.gsub(/^0+/,"")
      @episode  = @episode.gsub(/^0+/,"")
      
    else
      @type = "Unknown"
      @name = " "
    end
    
  end
  
  # returns a scrubbed version of the filename
  def scrubbed_name
    extension = @fileName.split(".")[@fileName.split(".").length-1]
    
    if @season.to_i < 10
      season_string = "S0{#@season}"
    else
      season_string = "S#{@season}"
    end
    
    if @episode.to_i < 10
      episode_string = "E0#{@episode}"
    else
      episode_string = "E#{@episode}"
    end 
    
    [@name.gsub(" ","."),[season_string,episode_string].join(""),extension].join(".")
  end
  
  def to_s
    [@type,@name,"Season #{@season}","Episode: #{@episode}",@fileName].join(" / ")
  end
  
  def fileName
    @fileName
  end
  def name
    @name
  end
  def type
    @type
  end
  def episode
    @episode
  end
  def season
    @season
  end
end