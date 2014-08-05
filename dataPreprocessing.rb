require 'csv'
require 'date'

path = '../../'
spaceID = '95861059'
newFileName = path + spaceID + "New.csv" 
# print newFileName

newF = File.new(newFileName, "wb")

CSV.foreach (File.path(path + spaceID + '.csv') ) do |row|
      date = row[1].split('/')
      datem = date[0].to_i
      dated = date[1].to_i
      datey = (date[2].to_i + 2000)
      datewd= (Date.new(datey, datem, dated).wday)
      val  = row[2].to_s
      newF << (datey.to_s+","+datem.to_s+","+dated.to_s+","+datewd.to_s+","+val+"\n")
end