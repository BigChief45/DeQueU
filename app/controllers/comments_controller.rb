class CommentsController < ApplicationController

    def create
        @story = Story.find(params[:story_id])
        @comment = @story.comments.new(comments_params)
        @comment.user = current_user
        
        respond_to do |format|
            if @comment.save
                format.html { redirect_to @story, :flash => { :success => 'Tu comentario ha sido posteado.' } }
                format.json { render :show, status: :created, location: @comment }
            else
                format.html { render 'new', :flash => { :danger => 'Hubo un error al tratar de postear tu comentario.' } }
                format.json { render json: @comment.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        
        def find_comment
           @comment = Comment.find(params[:id]) 
        end
    
        def comments_params
           params.require(:comment).permit(:comment, :user_id, :story_id) 
        end
end
