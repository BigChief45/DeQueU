class CategoriesController < ApplicationController
    
    before_action :authenticate_user!
    before_action :find_category, only: [:edit, :update, :destroy]
    
    
    def index
       @categories = Category.all.order("created_at ASC") 
    end
    
    def new
        @category = Category.new
        
    end
    
    def create
        @category = Category.new(category_params)
        
        respond_to do |format|
            if @category.save
                format.html { redirect_to categories_path, :flash => { :success => 'Categoria creada exitosamente.' } }
                format.json { render :index, status: :created, location: @category }
            else
                format.html { render 'new', :flash => { :danger => 'Hubo un error al tratar de crear la categoria.' } }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def edit
        
    end
    
    def update
        respond_to do |format|
            if @category.update(category_params)
                format.html { redirect_to categories_path, :flash => { :success => 'Categoria fue editada exitosamente.' } }
                format.json { render :show, status: :updated, location: @category }
            else
                format.html { render :edit, :flash => { :danger => 'Hubo un error al tratar de editar la categoria.' } }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def destroy
        respond_to do |format|
            if @category.destroy
                format.html { redirect_to categories_path, :flash => { :success => 'Categoria fue eliminada exitosamente.' } }
            else
                format.html { redirect_to :index, :flash => { :danger => 'Hubo un error al tratar de eliminar la categoria.' } }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end
    
    private
        
        def category_params
           params.require(:category).permit(:name, :glyphicon) 
        end
        
        def find_category
           @category = Category.find(params[:id]) 
        end
    
end
