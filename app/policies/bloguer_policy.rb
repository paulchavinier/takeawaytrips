class BloguerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show? # tous les users (signed in) peuvent voir des pages de blogueurs
    true
  end

end
