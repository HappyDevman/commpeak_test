class TicketsPolicy < ApplicationPolicy
  def index?
    role_from?(:basic)
  end

  def show?
    index?
  end

  def new?
    role_from?(:manager)
  end

  def edit?
    new?
  end

  def submit?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end

  def import_csv?
    new?
  end
end
