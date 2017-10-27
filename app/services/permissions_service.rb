class PermissionsService
  def initialize(user, controller, action)
    @user       = user || User.new
    @controller = controller
    @action     = action
  end

  def authorized?
    if @user.platform_admin?
      return platform_admin_permissions
    elsif @user.business_admin?
      return business_admin_permissions
    elsif @user.business_manager?
      return business_manager_permissions
    elsif @user.admin?
      return admin_permissions
    elsif @user.registered_user?
      return registered_user_permissions
    else
      return default_permissions
    end
  end

  def business_admin_permissions
    if business_manager_permissions
      return true
    end
    return true if @controller == 'vendors'
  end

  def business_manager_permissions
    return true if @controller == 'vendors' && (%w(index show)).include?(@action)
    return true if @controller == 'vendor/items'
    return true if @controller == 'items'
    return true if @controller == 'vendor/orders'
    return true if @controller == 'sessions' && (%w(new create destroy)).include?(@action)
    return true if @controller == 'users' && (%w(dashboard)).include?(@action)
  end

  def platform_admin_permissions
    if business_manager_permissions
      return true
    else
      return true if @controller == 'vendors' && (%w(index show update)).include?(@action)
    end
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

  def registered_user_permissions
    if default_permissions
      return true
    else
      return true if @controller == 'orders'
      return true if @controller == 'password' && (%w(index show)).include?(@action)
      return true if @controller == 'users'
    end
  end

  def default_permissions
    return true if @controller == 'users' && (%w(dashboard new create)).include?(@action)
    return true if @controller == 'items' && (%w(index show)).include?(@action)
    return true if @controller == 'tags' && (%w(index show)).include?(@action)
    return true if @controller == 'vendors' && (%w(index show dashboard)).include?(@action)
    return true if @controller == 'sessions' && (%w(new create destroy)).include?(@action)
    return true if @controller == 'carts'
    return true if @controller == 'vendor/items' && (%w(index show)).include?(@action)
  end
end
