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
       column("微信", :width => 40)
       column("com.weuxin.me.name", :width => 30, :align => 'right', :padding => 5)
       column("聊天社交", :width => 15)
     end
     row :color => 'red' do
        column '微信'
        column 'com.pernanana.name'
        column '社交聊天', :color => 'blue'
     end
     # row do
     #   column('应用ID')
     #   column("#{@app_id}",:width => 30, :align => 'center')
     #   column('√', :width => 15)
     # end
     # row do
     #   column('应用类别')
     #   column("#{@gener}",:width => 30, :align => 'center')
     #   column('√', :width => 15)
     # end
     # # row do
     # #   column('应用链接')
     # #   column("#{@link}")
     # # end
     # row do
     #   column('应用版本')
     #   column("#{@version}",:width => 30, :align => 'center')
     #   column('√', :width => 15)
     # end     
   end
  end
end
