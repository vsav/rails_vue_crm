class FindOrganizations
  attr_accessor :initial_scope

  def initialize(initial_scope)
    @initial_scope = initial_scope
  end

  def call(params)
    scoped = search(initial_scope, params[:search])
    scoped = sort(scoped, params[:sort_by], params[:descending])
  end

  private

  def search(scoped, filter)
    filter ? scoped.where("name ILIKE ? OR inn ILIKE ? OR ogrn ILIKE ?", "%#{filter}%", "%#{filter}%", "%#{filter}%") : scoped
  end

  def sort(scoped, sort_by, descending)
    descending == 'true' ? order = :desc : order = :asc
    sort_by ? scoped.order(sort_by => order) : scoped
  end
end
