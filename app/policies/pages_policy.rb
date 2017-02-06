class PagesPolicy < Struct.new(:user, :page)
  def show?
     true 
  end
end