module UsersHelper
  def options_for_users
    User.where(employment_id: nil)
      .collect {|p| [ p.first_name, p.id ] }
  end
end