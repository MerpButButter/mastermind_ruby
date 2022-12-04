class String
  def color(color)
    start = "\e["
    ending = "\e[0m"
    text = self

    case color
    when "red"
      start << "31;"
    when "green" 
      start << "32;"
    when "orange" 
      start << "33;"
    when "blue" 
      start << "34;"
    when "purple" 
      start << "35;"
    when "cyan" 
      start << "36;"
    when "white"
      start << "37;"
    else
      puts("Picked wrong color.".color("red"))
    end
    
    "#{start}40m#{text}#{ending}"
  end

  def mode(mode)
    start = "\e["
    ending = "\e[0m"
    text = self

    case mode
    when "normal"
      start << "0;"
    when "bold"
      start << "1;"
    when "dim" 
      start << "2;"
    when "italic" 
      start << "3;"
    when "underscored" 
      start << "4;"
    when "background" 
      start << "7;"
    when "crossed"
      start << "9;"
    else
      puts("Picked wrong mode.".color("red"))
    end
    
    "#{start}40m#{text}#{ending}"
  end

  def style(color, mode)
    start = "\e["
    ending = "\e[0m"
    text = self

    case mode
    when "normal"
      start << "0;"
    when "bold"
      start << "1;"
    when "dim" 
      start << "2;"
    when "italic" 
      start << "3;"
    when "underscored" 
      start << "4;"
    when "background" 
      start << "7;"
    when "crossed"
      start << "9;"
    else
      puts("Picked wrong mode.".color("red"))
    end

    case color
    when "red"
      start << "31;"
    when "green" 
      start << "32;"
    when "orange" 
      start << "33;"
    when "blue" 
      start << "34;"
    when "purple" 
      start << "35;"
    when "cyan" 
      start << "36;"
    when "white"
      start << "37;"
    else
      puts("Picked wrong color.".color("red"))
    end
    
    "#{start}40m#{text}#{ending}"
  end
end