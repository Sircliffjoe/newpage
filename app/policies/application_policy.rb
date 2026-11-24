class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    admin_access?
  end

  def show?
    admin_access?
  end

  def create?
    content_access?
  end

  def new?
    create?
  end

  def update?
    content_access?
  end

  def edit?
    update?
  end

  def destroy?
    user&.super_admin? || false
  end

  private

  def admin_access?
    user.present? && (user.super_admin? || user.content_editor? || user.staff?)
  end

  def content_access?
    user.present? && (user.super_admin? || user.content_editor?)
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :user, :scope
  end
end
