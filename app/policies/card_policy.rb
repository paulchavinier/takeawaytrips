class CardPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create? # tous les user (signed in) peuvent créer des adresses
    true
  end

  def update?
      # Seul le owner des adresses peut les modifier
      record.user == user # record designe le guide qu on s'est passé à la méthode authorize.
  end

  def destroy?
    record.user == user
  end

  def update_card_to_guide?
    true
  end

end
