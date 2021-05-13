class CommentsPolicy < ApplicationPolicy
  def new?
    role_from?(:manager)
  end

  def edit?
    new?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
