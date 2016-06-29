class GuidePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(user: user)
    end
  end

  def show?
    # la show des guides uniquement s'ils ont été créé par le user ou des amis du user
    privacy? || user.admin

  end

  def create? # tous les user (signed in) peuvent créer des guides
    true
  end

  def update?
      # Seul le owner du guide peut le modifier
      record.user == user # record designe le guide qu on s'est passé à la méthode authorize.
  end

  def destroy?
    record.user == user
  end


  private

  def is_friend_user?
    test_uid = record.user.uid
    friends_table = user.get_friendslist
    test = 0
    friends_table.each do |friend|
      if friend["id"] == test_uid
        test = 1
      end
    end
    test == 1
  end

  def privacy?
    if record.privacy == "private"
      record.user == user
    elsif record.privacy == "facebook" || record.privacy == nil
      record.user == user || is_friend_user?
    else
      true
    end
  end

end
