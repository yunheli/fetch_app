require 'command_line_reporter'

class Show
  include CommandLineReporter
  def initialize name,app_id,desc,gener,link,version
    @name = name
    @app_id = app_id
    @desc = desc
    @gener = gener
    @link = link
    @version = version
  end
  def run
    table(:border => true) do
     row do
       column('应用名称', :width => 20)
       column("#{@name}", :width => 50)
     end
     row do
       column('应用ID')
       column("#{@app_id}")
     end
     row do
       column('应用类别')
       column("#{@gener}")
     end
     # row do
     #   column('应用链接')
     #   column("#{@link}")
     # end
     row do
       column('应用版本')
       column("#{@version}")
     end     
   end
  end
end
