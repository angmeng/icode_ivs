class ReportController < ApplicationController
  before_filter :authenticated_admin_and_user
  before_filter :check_authorization
  before_filter :set_locale

  prawnto :prawn => { :top_margin => 75 }
  
  def purchase_order_by_project_query
    @search = PurchaseOrderItem.search(params[:search])
    if params[:search]
      @purchase_orders = @search.all(:joins => [:product, {:purchase_order => [:supplier, :project]}], :conditions => ["deleted = ? and void = ?", false, false], :order => "projects.name, products.name, suppliers.name").uniq
      render :layout => "purchase_order_report"
    else
      @purchase_orders = []
    end
  end
  
  def purchase_order_by_supplier_query
    @search = PurchaseOrderItem.search(params[:search])
    if params[:search]
      @purchase_orders = @search.all(:joins => [:product, {:purchase_order => [:supplier, :project]}], :conditions => ["deleted = ? and void = ?", false, false], :order => "suppliers.name, projects.name, products.name").uniq
      render :layout => "purchase_order_report"
    else
      @purchase_orders = []
    end
  end
  
  def purchase_order_by_product_query
    @search = PurchaseOrderItem.search(params[:search])
    if params[:search]
      @purchase_orders = @search.all(:joins => [:product, {:purchase_order => [:supplier, :project]}], :conditions => ["deleted = ? and void = ?", false, false], :order => "products.name, projects.name, suppliers.name").uniq
      render :layout => "purchase_order_report"
    else
      @purchase_orders = []
    end
  end

  def purchase_orders
    @search = PurchaseOrderItem.search(params[:search])
    if params[:search]
      if params[:order_by]
        @sort = params[:order_by].split(", ")
        @purchase_orders = @search.all(:joins => [:product, {:purchase_order => [:supplier, :project]}], :conditions => ["deleted = ? and void = ?", false, false], :order => "#{@sort[0]}.name, #{@sort[1]}.name, #{@sort[2]}.name").uniq
      else
        @purchase_orders = @search.all(:joins => [:product, {:purchase_order => [:supplier, :project]}], :conditions => ["deleted = ? and void = ?", false, false], :order => "products.name, projects.name, suppliers.name").uniq
      end
     @material_category = MaterialCategory.find_by_id(params[:search][:material_material_category_id_equals].to_i)
     render :layout => "purchase_order_report"
    else
      @purchase_orders = []
    end
  end

#  def sales
#    
#  end
#  
#  def profit_and_loss
#    @report_categories = current_user.report_categories
#    @product_categories = ProductCategory.all(:order => "name")
#    
#  end
#  
#  def add_item_to_repot_category
#    begin
#      report_category = ReportCategory.find(params[:item][:report_category_id].to_i)
#      params[:item].each {|product_category_id, content|
#      
#       found = report_category.report_category_items.find_by_product_category_id(product_category_id.to_i)
#       unless found
#         if product_category_id.to_i > 0 
#           report_category.report_category_items.create(:product_category_id => product_category_id.to_i)
#         end
#       end
#      }
#      flash[:notice] = (t "flashes.operation_completed")
#      redirect_to :action => "profit_and_loss"
#    rescue
#      flash[:error] = (t "flashes.add_new_group")
#      redirect_to :action => "profit_and_loss"
#    end
#  end
#  
#  def add_group
#    if params[:group_name].empty?
#      flash[:error] = (t "flashes.fill_in_group_name")
#    else
#      current_user.report_categories.create(:name => params[:group_name])
#      flash[:notice] = (t "flashes.group_added")
#    end
#    
#    redirect_to :action => "profit_and_loss"
#  end
#  
#  def remove_group
#    group = current_user.report_categories.find(params[:id])
#    group.destroy
#    flash[:notice] = (t "flashes.group_removed")
#    redirect_to :action => "profit_and_loss"
#  end
#  
#  def remove_item
#    item = ReportCategoryItem.find(params[:id])
#    item.destroy
#    flash[:notice] = (t "flashes.item_removed")
#    redirect_to :action => "profit_and_loss"
#  end
#  
#  def stock_report
#    @products = Product.all(:joins => :product_category, :order => "product_categories.name, name")
#    @gross = @products.inject(0) {|sum, c| sum += c.total_cost }
#    respond_to do |format|
#      format.html
#      format.pdf { prawnto :inline => true}
#    end
#  end
#
#  def profit_and_loss_report
#    if params[:from].blank? or params[:to].blank?
#      flash[:error] = (t "flashes.valid_date_period")
#      redirect_to :action => "profit_and_loss"
#    else
#      from = Date.parse(params[:from])
#      to = Date.parse(params[:to])
#      if from > to 
#        flash[:error] = (t "flashes.valid_date_period")
#        redirect_to :action => "profit_and_loss"
#      else
#        if params[:grouping] == "1"
#          
#          invoices = Invoice.get_sales_from(from.to_s, to.to_s)
#          @total_expenses = Expense.calculate_expenses(from, to)
#          @results = Invoice.calculate_each_report_category(current_user, invoices)
#          render :template => '/report/grouping_profit_and_loss_report'
#        else
#          @invoices = Invoice.get_sales_from(from.to_s, to.to_s)
#          @total_sales = @invoices.inject(0) {|sum, item| sum + item.total_amount}
#          total_profit = @invoices.inject(0) {|sum, item| sum + item.total_profit} 
#          
#          @total_expenses = Expense.calculate_expenses(from, to)
#          @total_profit = total_profit - @total_expenses
#        end
#      end
#    end
#  end
#  
#  def sales_report
#    if params[:from].blank? or params[:to].blank?
#      flash[:error] = (t "flashes.valid_date_period")
#      redirect_to :action => "sales"
#    else
#      from = Date.parse(params[:from])
#      to = Date.parse(params[:to])
#      if from > to 
#        flash[:error] = (t "flashes.valid_date_period")
#        redirect_to :action => "sales"
#      else
#        @invoices = Invoice.get_sales_from(from.to_s, to.to_s)
#        @total = @invoices.inject(0) {|sum, item| sum + item.total_amount}
#      end
#      
#    end
#  end
  

  

end
