class Ability
  include CanCan::Ability

  def initialize(user)
    def initialize(user)
      user ||= User.new

      if user.member?('disabled')
        cannot :manage, :all
      else
        if user.member?('admin')
          can :manage, :admin
        end
        if user.member?('sample') 
          can :manage, :stock
        end
        if user.member?('project')
          can :manage, :fep
        end
        if user.member?('clinic')
          can :manage, :clinic
        end

        can :read, :home
      end
    end
  end
end
