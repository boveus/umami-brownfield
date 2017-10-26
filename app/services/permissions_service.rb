class PermissionsService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    if @user.business_manager?
      return business_manager_permissions
    elsif @user.admin?
      return admin_permissions
    else
      return default_permissions
    end
  end

  def business_manager_permissions
    return true if @controller == 'vendor/items' && (%w(index show edit update)).include?(@action)
  end

  def admin_permissions
    return true if @controller == 'users' && @action == 'dashboard'
    return true if @controller == 'admin/base'
    return true if @controller == 'admin/items'
    return true if @controller == 'admin/orders'
    return true if @controller == 'admin/users'
    return true if @controller == 'items'
    return true if @controller == 'sessions' && (%w(new create destroy)).include?(@action)
  end

  def default_permissions
    return true if @controller == 'password' && (%w(index show)).include?(@action)
    return true if @controller == 'items' && (%w(index show)).include?(@action)
    return true if @controller == 'tags' && (%w(index show)).include?(@action)
    return true if @controller == 'vendors' && (%w(index show dashboard)).include?(@action)
    return true if @controller == 'orders' && (%w(index show)).include?(@action)
    return true if @controller == 'sessions' && (%w(new create destroy)).include?(@action)
    return true if @controller == 'cart' && (%w(show)).include?(@action)
  end
end
