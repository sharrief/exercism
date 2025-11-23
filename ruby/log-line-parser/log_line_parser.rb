class LogLineParser
  def initialize(line)
    @line = line
  end

  def message
    @line.gsub(/^\[[A-Z]*\]:/, '').gsub(/^\s*/,'').gsub(/\s*$/, '')
  end

  def log_level
    @line.gsub(/^\[([A-Z]*)\].*/, '\1').gsub(/\s/, '').downcase
  end

  def reformat
    "#{self.message} (#{self.log_level})"
  end
end
