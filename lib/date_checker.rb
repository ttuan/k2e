module DateChecker
  def last_sync_date
    unless File.file?(file_name)
      File.open(file_name, "w") {|file| file.write("1970-01-01T00:00:00+07:00")}
    end

    @sync_date ||= DateTime.parse File.read(file_name)
  end

  def update_last_sync_date
    File.open(file_name, "w") {|file| file.write(DateTime.now)}
  end

  private
  def file_name
    @file_name ||=  "./data/last_sync_date.txt"
  end
end
