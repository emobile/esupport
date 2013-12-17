class Ability
  include CanCan::Ability
  
  def initialize(user_or_client)
    user_or_client ||= User.new # guest user (not logged in)
    @user = User.find_by_id(user_or_client.id)
    user_or_client ||= Client.new
    @client = Client.find_by_id(user_or_client.id)
    if @user and @user.role.super_admin == true
      can :manage, :all
    elsif @user and @user.role.branch_admin == true
      can :read, Branch 
      can [:new, :create, :edi, :update], Branch#, :id => @user.branch_id
      can :manage, Client
      #can [:edi, :update, :show, :get_bill_by_client_id], Bill
      can [:index, :show], Role
      can [:new, :create, :show], Comment#, :fullname => @user.fullname
      can :manage, User#, :branch_id => @user.branch_id 
      can :manage, Order#, :branch_id => @user.branch_id 
      can [:index, :show], Status#, :branch_id => @user.branch_id 
      can :manage, Part#, :branch_id => @user.branch_id 
      can :manage, Workshop#, :branch_id => @user.branch_id 
      can :manage, Cellphone#, :branch_id => @user.branch_id 
      can :manage, Computer#, :branch_id => @user.branch_id 
      can :manage, Progress#, :branch_id => @user.branch_id 
      can :manage, ClientNeed#, :branch_id => @user.branch_id   
      can :manage, Bill
    elsif @client
      can :index, Branch 
      can :show, Branch
      can :show, Client#, :id => @client.id 
      can :edit, Client#, :id => @client.id 
      can :update, Client 
      can :new, Comment 
      can :create, Comment 
      can :show, Comment#, :id => @client.id  
      can :show, Order
      can :show, Part      
      can [:index, :show]#, Order, :client_id => @client.id 
      can [:index, :show,:edit, :update], Bill#, :client_id => @client.id 
    else   
      can [:new, :create, :edit, :update, :show], Client 
    end
  end
  #  def initialize(client)
  #    client ||= Client.new # guest user (not logged in)
  #    @client = User.find_by_id(client.id)
  #    can :managa, Order, :client_id => @client.id 
  #  end

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
  # https://github.com/ryanb/cancan/wiki/Defining-Abilities
end
