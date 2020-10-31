module API
  module V1
    class Accounts < Grape::API
      include API::V1::Concerns::Controller

      resources :accounts do
       
        desc "List of accounts"
        
        get "", jbuilder: Accounts.view_path("accounts/index") do
          accounts  = Account.all
          @accounts = paginate(accounts)
        end

        
        desc "Show Account"
        params do
          requires :id, type: Integer
        end
        get "/:id", jbuilder: Accounts.view_path("accounts/show") do
          @account = Account.find(params[:id])
        end

        desc "Delete Account"
        params do
          requires :id, type: Integer
        end
        delete "/:id" do
          @account = Account.find(params[:id])
          @account.destroy!
          {}
        end

        desc "Create new Account"
        params do
          requires :account, type: Hash do
            requires :account_type, type: String
            requires :customer_id, type: Integer
            requires :open_date, type: Date
            requires :branch, type: String
          end
        end
        post "", jbuilder: Accounts.view_path("accounts/show") do
          customer = CustomerApp::Customer.find_or_create_customer(params[:customer_id])
          @account = Account.new(declared_params[:account])
          @account.customer_id = customer['id']
          @account.customer_name = customer['user_name']
          @account.save!
        end

      end
    end
  end
end        