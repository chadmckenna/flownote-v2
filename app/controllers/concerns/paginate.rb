module Paginate
  extend ActiveSupport::Concern

  included do
    before_action :set_page
  end

  def paginate model
    @total_pages = (model.count / @limit) + 1
    return model.offset(@offset).limit(@limit)
  end

  private
  def set_page
    @page = 1
    @limit = 10
    @offset = 0
    if params[:page].to_i > 1
      @page = params[:page].to_i
      @offset = (@page - 1) * @limit
    end
  end
end
