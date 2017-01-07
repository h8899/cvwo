class TagsController < ApplicationController
	def index
		@q = Tag.ransack(params[:q])
		@tags = @q.result(distinct: true)
		@tags = @tags.sort { |a,b| a[:name] <=> b[:name] }
	end
 
	def show
	  @tag = Tag.find(params[:id])
	end
	
	def destroy
	  @tag = Tag.find(params[:id])
      @tag.destroy
      redirect_to tags_path
	end
end
