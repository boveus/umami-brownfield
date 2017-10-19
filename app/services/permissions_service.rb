class PermissionsService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    default_routes
    if @user.business_manager?
        business_manager_permissions
    else
      return false
    end
  end

  def default_routes
    return true if @controller == 'items' && @action == (%w(index show))
    return true if @controller == 'tags' && @action == (%w(index show))
    return true if @controller == 'vendors' && @action == (%w(index show))
    return true if @controller == 'sessions' && @action == (%w(new create destroy))
    return true if @controller == 'cart' && @action == (%w(show))
  end

end
