class Ability
    include CanCan::Ability

    def initialize(user)
        # Define abilities for the passed in user here. For example:
        #can :read, :all #access all to read in the app
        user ||= User.new # guest user (not logged in)
        #Admin User
        if user.superadmin_role?
            can :manage, :all               #admin can manage only these models
            can :access, :rails_admin       # only allow admin users to access Rails Admin
            can :manage, :dashboard         # allow access to dashboard
            # can :edit, User, id: user.id #admin can edit himself
        ########################################################
        #Seller User
        elsif user.seller_role?
            can :create, Product
            can [:edit, :destroy], Product, store_id: user.store.id
        #Buyer User
        else
            #write the buyer permissions
        end
        #
        # The first argument to `can` is the action you are giving the user
        # permission to do.
        # If you pass :manage it will apply to every action. Other common actions
        # here are :read, :create, :update and :destroy.
        #
        # The second argument is the resource the user can perform the action on.
        # If you pass :all it will apply to every resource. Otherwise pass a Ruby
        # class of the resource.
        #
        # The third argument is an optional hash of conditions to further filter the
        # objects.
        # For example, here the user can only update published articles.
        #
        #   can :update, Article, :published => true
        #
        # See the wiki for details:
        # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    end
end