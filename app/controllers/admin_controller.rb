class AdminController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        
        if !current_user.admin?
            redirect_to qp2_path
        end
        
        @users = User.all
    end
end
