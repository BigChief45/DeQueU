class StoriesController < ApplicationController
    
    before_action :find_story, only:[:show, :edit, :update, :destroy, :upvote]
    before_action :authenticate_user!, except: [:index, :show]
    
    load_and_authorize_resource param_method: :story_params
    
    def index
        @categories = Category.all
        
        #Ransack
        @q = Story.ransack(params[:q])
        
        # Category Sort and Order
        if ( params[:category].blank? || params[:category] == "Todos" )
            if params[:sort].present?
                @stories = @q.result(distinct: true).order("cached_votes_up DESC")
            else
                @stories = @q.result(distinct: true).order("created_at DESC")
            end
        else
            @category_id = Category.find_by(name: params[:category]).id
            if params[:sort].present?
                @stories = Story.where(category_id: @category_id).order("cached_votes_up DESC")
            else
                @stories = Story.where(category_id: @category_id).order("created_at DESC")
            end
        end
        
        # Pagination
        @stories = @stories.paginate(:page => params[:page], :per_page => 20)
        
    end
    
    def my_stories
       @my_stories = current_user.stories 
    end
    
    
    def new
        @story = current_user.stories.build
    end
    
    def create
        @story = current_user.stories.build(story_params)
        
        respond_to do |format|
            if @story.save
                format.html { redirect_to @story, :flash => { :success => 'Tu historia ha sido posteada exitosamente.' } }
                format.json { render :show, status: :created, location: @story }
            else
                format.html { render 'new', :flash => { :danger => 'Hubo un error al tratar de postear tu historia.' } }
                format.json { render json: @story.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def show
        # Comments Pagination
        @comments = @story.comments.paginate(:page => params[:page], :per_page => 10)
    end
    
    def edit
        
    end
    
    def update
        respond_to do |format|
            if @story.update(story_params)
                format.html { redirect_to @story, :flash => { :success => 'Tu historia fue editada exitosamente.' } }
                format.json { render :show, status: :updated, location: @story }
            else
                format.html { render :edit, :flash => { :danger => 'Hubo un error al tratar de editar tu historia.' } }
                format.json { render json: @story.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        respond_to do |format|
            @story.destroy
            format.html { redirect_to qp2_path, :flash => { :success => 'La historia fue eliminada exitosamente.' } }
            format.json { redirect_to qp2_path, status: :destroyed, location: @story }
        end
    end
    
    def upvote
        @story.upvote_by current_user
        redirect_to :back
    end
    
        private
        
            def story_params
                params.require(:story).permit(:title, :description, :category_id, :user_id)
            end
            
            def find_story
                @story = Story.find(params[:id])    
            end
    
end
