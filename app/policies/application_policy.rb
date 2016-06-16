class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    scope.where(:id => record.id).exists? #authorise la show si et seulement si le record exist sur le model sur lequel on est.
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  # def rails_admin?(action)
  #   case action
  #     when :dashboard
  #       user.admin? if user
  #     when :index
  #       user.admin?
  #     when :show
  #       user.admin?
  #     when :new
  #       user.admin?
  #     when :edit
  #       user.admin?
  #     when :destroy
  #       user.admin?
  #     when :export
  #       user.admin?
  #     when :history
  #       user.admin?
  #     when :show_in_app
  #       user.admin?
  #     else
  #       raise ::Pundit::NotDefinedError, "unable to find policy #{action} for #{record}."
  #   end
  # end

  # def scope
  #   Pundit.policy_scope!(user, record.class)
  # end


  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope
    end
  end

  private

  def admin?
    user.admin
  end

end