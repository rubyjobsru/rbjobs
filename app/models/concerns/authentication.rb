module Authentication
  extend ActiveSupport::Concern

  def authorize!(action, vacancy)
    case action
    when :read
      return vacancy.approved? || admin?(vacancy)
    when :edit, :update
      return (vacancy.approved? && owner?(vacancy)) || admin?(vacancy)
    when :destroy, :approve
      return admin?(vacancy)
    else
      raise StandartError
    end
  end

end
