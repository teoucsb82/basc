module ApplicationHelper
  def admin_user?
    current_user && current_user.admin?
  end

  def stripe_currency(amount)
    sprintf('%.2f', amount * 100)
  end
end
