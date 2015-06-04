class StoriesController < ApplicationController
    
    before_action :find_story, only:[:show, :edit, :update, :destroy, :upvote]
    before_action :authenticate_user!, except: [:index, :show]
    
    load_and_authorize_resource param_method: :story_params
    
    def index
        #Ransack
        @q = Story.ransack(params[:q])
        
        if ( params[:category].blank? || params[:category] == "Todos" )
            @stories = @q.result(distinct: true).order("created_at DESC")
        else
            @category_id = Category.find_by(name: params[:category]).id
            @stories = Story.where(category_id: @category_id)
        end
        
        # Pagination
        @stories = @stories.paginate(:page => params[:page], :per_page => 20)
        
        @categories = Category.all
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
