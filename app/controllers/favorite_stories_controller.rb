class FavoriteStoriesController < ApplicationController
    
    before_action :find_story
  
    def create
        respond_to do |format|
            if Favorite.create(favorited: @story, user: current_user)
                format.html { redirect_to @story, :flash => { :success => 'Esta historia ha sido agregada a tus favoritos.' } }
                format.json { render :show, status: :created, location: @story }
            else
                format.html { redirect_to @story, :flash => { :danger => 'Hubo un error al tratar de agregar la historia a tus favoritos.' } }
                format.json { render json: @story.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        respond_to do |format|
            Favorite.where(favorited_id: @story.id, user_id: current_user.id).first.destroy
            format.html { redirect_to @story, :flash => { :success => 'Esta historia ha sido eliminada de tus favoritos.' } }
            format.json { render :show, status: :created, location: @story }
        end
    end
    
    private
    
        def find_story
            @story = Story.find(params[:story_id] || params[:id])
        end
    
end
