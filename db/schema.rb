# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20151215110545) do

  create_table "accessible_menus", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "link",                      :default => "/"
  end

  create_table "authorizations", :force => true do |t|
    t.integer  "department_id"
    t.integer  "accessible_menu_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "banks", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "card_categories", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.integer  "priority",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cheques", :force => true do |t|
    t.string   "cheque_number",       :limit => 20
    t.integer  "bank_id"
    t.integer  "reference_id"
    t.integer  "cheque_type_id"
    t.string   "owner_name",          :limit => 45
    t.date     "cheque_date"
    t.boolean  "clear"
    t.string   "bank_account_number", :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",                            :precision => 12, :scale => 2, :default => 0.0
  end

  add_index "cheques", ["bank_id"], :name => "index_cheques_on_bank_id"
  add_index "cheques", ["cheque_type_id"], :name => "index_cheques_on_cheque_type_id"
  add_index "cheques", ["reference_id"], :name => "index_cheques_on_reference_id"

  create_table "commissions", :force => true do |t|
    t.integer  "salesman_id"
    t.integer  "product_id"
    t.decimal  "percentage",  :precision => 10, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "companies", :force => true do |t|
    t.string   "name",         :limit => 100
    t.text     "address"
    t.string   "phone_number", :limit => 12
    t.string   "fax_number",   :limit => 12
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credit_cards", :force => true do |t|
    t.string   "card_number",      :limit => 20
    t.integer  "bank_id"
    t.integer  "reference_id"
    t.integer  "card_type_id"
    t.integer  "card_category_id"
    t.string   "owner_name",       :limit => 45
    t.boolean  "clear"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "amount",                         :precision => 12, :scale => 2, :default => 0.0
  end

  add_index "credit_cards", ["bank_id"], :name => "index_credit_cards_on_bank_id"
  add_index "credit_cards", ["card_category_id"], :name => "index_credit_cards_on_card_category_id"
  add_index "credit_cards", ["card_type_id"], :name => "index_credit_cards_on_card_type_id"
  add_index "credit_cards", ["reference_id"], :name => "index_credit_cards_on_reference_id"

  create_table "currencies", :force => true do |t|
    t.string   "name",        :limit => 10
    t.string   "code",        :limit => 10
    t.string   "description", :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  create_table "customer_payments", :force => true do |t|
    t.date     "payment_date"
    t.integer  "customer_id"
    t.string   "reference_number",  :limit => 20
    t.string   "resit_number",      :limit => 20
    t.text     "description"
    t.integer  "payment_method_id"
    t.decimal  "amount",                          :precision => 12, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "customer_payments", ["customer_id"], :name => "index_customer_payments_on_customer_id"
  add_index "customer_payments", ["payment_method_id"], :name => "index_customer_payments_on_payment_method_id"

  create_table "customer_pricings", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "product_id"
    t.decimal  "amount",      :precision => 12, :scale => 3, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "home_address"
    t.text     "company_address"
    t.string   "mobile_number"
    t.string   "home_phone_number"
    t.string   "office_phone_number"
    t.string   "fax_number"
    t.decimal  "credit_limit",                       :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "used_credit",                        :precision => 10, :scale => 2, :default => 0.0
    t.boolean  "suspend",                                                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "additional_phone_one", :limit => 20
    t.string   "additional_phone_two", :limit => 20
    t.decimal  "paid_credit",                        :precision => 12, :scale => 2, :default => 0.0
  end

  create_table "departments", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.boolean  "builtin",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "message"
  end

  create_table "document_authorizations", :force => true do |t|
    t.integer  "department_id"
    t.integer  "document_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_categories", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.boolean  "builtin",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "document_storages", :force => true do |t|
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "document_category_id",  :default => 1
  end

  create_table "expenses", :force => true do |t|
    t.date     "expense_date"
    t.string   "title",        :limit => 45
    t.text     "description"
    t.decimal  "amount",                     :precision => 12, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goods_receive_note_items", :force => true do |t|
    t.integer  "goods_receive_note_id"
    t.integer  "product_id"
    t.decimal  "quantity",               :precision => 12, :scale => 3, :default => 0.0
    t.decimal  "unit_price",             :precision => 12, :scale => 3, :default => 0.0
    t.string   "remark"
    t.boolean  "rejected",                                              :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_location_id",                                     :default => 0
    t.integer  "project_id",                                            :default => 0
    t.integer  "material_id",                                                              :null => false
    t.integer  "purchase_order_item_id",                                                   :null => false
    t.decimal  "deliver_quantity",       :precision => 12, :scale => 3, :default => 0.0
    t.boolean  "settled",                                               :default => false
    t.integer  "currency_id"
  end

  add_index "goods_receive_note_items", ["currency_id"], :name => "index_goods_receive_note_items_on_currency_id"
  add_index "goods_receive_note_items", ["material_id"], :name => "index_goods_receive_note_items_on_material_id"
  add_index "goods_receive_note_items", ["product_id"], :name => "index_outlet_goods_receive_note_items_on_product_id"
  add_index "goods_receive_note_items", ["project_id"], :name => "index_goods_receive_note_items_on_project_id"
  add_index "goods_receive_note_items", ["purchase_order_item_id"], :name => "index_goods_receive_note_items_on_purchase_order_item_id"
  add_index "goods_receive_note_items", ["settled"], :name => "index_goods_receive_note_items_on_settled"

  create_table "goods_receive_notes", :force => true do |t|
    t.integer  "supplier_id"
    t.string   "grn_number",        :limit => 45
    t.date     "grn_date"
    t.text     "remark"
    t.boolean  "void",                            :default => false
    t.boolean  "settled",                         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "purchase_order_id",                                  :null => false
    t.string   "do_number"
    t.string   "invoice_number"
    t.string   "serial_number"
  end

  add_index "goods_receive_notes", ["purchase_order_id"], :name => "index_goods_receive_notes_on_purchase_order_id"
  add_index "goods_receive_notes", ["supplier_id"], :name => "index_outlet_goods_receive_notes_on_outlet_id"

  create_table "invoice_items", :force => true do |t|
    t.integer  "invoice_id"
    t.integer  "product_id"
    t.decimal  "quantity",          :precision => 12, :scale => 3, :default => 0.0
    t.decimal  "unit_price",        :precision => 12, :scale => 3, :default => 0.0
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "store_location_id",                                :default => 1
    t.decimal  "commission",        :precision => 12, :scale => 3, :default => 0.0
  end

  add_index "invoice_items", ["invoice_id"], :name => "index_invoice_items_on_invoice_id"
  add_index "invoice_items", ["product_id"], :name => "index_invoice_items_on_product_id"
  add_index "invoice_items", ["store_location_id"], :name => "index_invoice_items_on_store_location_id"

  create_table "invoices", :force => true do |t|
    t.date     "invoice_date"
    t.string   "invoice_number"
    t.integer  "customer_id"
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "void",           :default => false
    t.integer  "company_id",     :default => 1
    t.boolean  "deleted",        :default => false
    t.boolean  "settled",        :default => false
    t.integer  "sales_order_id"
  end

  add_index "invoices", ["company_id"], :name => "index_invoices_on_company_id"
  add_index "invoices", ["sales_order_id"], :name => "index_invoices_on_outlet_purchase_order_id"

  create_table "material_categories", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_groups", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_counting",               :default => false
  end

  add_index "material_groups", ["is_counting"], :name => "index_material_groups_on_is_counting"

  create_table "materials", :force => true do |t|
    t.string   "code",                 :limit => 45
    t.integer  "material_group_id"
    t.integer  "material_category_id"
    t.string   "description"
    t.integer  "uom_id"
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "kg",                                 :precision => 19, :scale => 3
  end

  add_index "materials", ["material_category_id"], :name => "index_materials_on_material_category_id"
  add_index "materials", ["material_group_id"], :name => "index_materials_on_material_group_id"
  add_index "materials", ["uom_id"], :name => "index_materials_on_uom_id"

  create_table "payment_methods", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.integer  "priority"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_groups", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.boolean  "suspend",                   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "product_movements", :force => true do |t|
    t.integer  "product_id"
    t.integer  "movement_category_id"
    t.integer  "reference_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.decimal  "unit_price",           :precision => 12, :scale => 2
    t.date     "movement_date"
    t.boolean  "deleted",                                             :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "debit"
    t.integer  "store_location_id",                                   :default => 1
  end

  add_index "product_movements", ["item_id"], :name => "index_product_movements_on_item_id"
  add_index "product_movements", ["movement_category_id"], :name => "index_product_movements_on_movement_category_id"
  add_index "product_movements", ["product_id"], :name => "index_product_movements_on_product_id"
  add_index "product_movements", ["reference_id"], :name => "index_product_movements_on_reference_id"
  add_index "product_movements", ["store_location_id"], :name => "index_product_movements_on_store_location_id"

  create_table "products", :force => true do |t|
    t.string   "name"
    t.integer  "product_category_id"
    t.text     "description"
    t.integer  "open_balance",                                                     :default => 0
    t.integer  "uom_id",                                                           :default => 0
    t.decimal  "selling_price",                     :precision => 12, :scale => 3
    t.boolean  "active",                                                           :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code",                :limit => 45
    t.integer  "stock_quantity",                                                   :default => 0
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.decimal  "unit_cost",                         :precision => 12, :scale => 3
    t.integer  "product_group_id"
  end

  add_index "products", ["product_group_id"], :name => "index_products_on_product_group_id"

  create_table "project_supervisors", :force => true do |t|
    t.string   "employee_number", :limit => 45
    t.string   "name",            :limit => 45
    t.string   "email",           :limit => 100
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "code",                  :limit => 45
    t.string   "name"
    t.string   "description"
    t.string   "address",               :limit => 45
    t.integer  "project_supervisor_id",               :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "completed",                           :default => false
  end

  add_index "projects", ["completed"], :name => "index_projects_on_completed"
  add_index "projects", ["project_supervisor_id"], :name => "index_projects_on_user_id"

  create_table "purchase_order_histories", :force => true do |t|
    t.integer  "history_id"
    t.integer  "year"
    t.string   "month",               :limit => 20
    t.string   "delivery_date",       :limit => 45
    t.integer  "pr_number"
    t.integer  "po_number"
    t.string   "project_code",        :limit => 45
    t.date     "po_issue_date"
    t.string   "supplier_code",       :limit => 45
    t.string   "material_code"
    t.string   "category",            :limit => 45
    t.text     "item_description"
    t.string   "uom",                 :limit => 45
    t.text     "remark"
    t.decimal  "unit_price",                        :precision => 12, :scale => 3
    t.integer  "qty"
    t.string   "deliver_to",          :limit => 45
    t.string   "term"
    t.string   "product_code",        :limit => 45
    t.string   "currency",            :limit => 20
    t.decimal  "currency_unit_price",               :precision => 12, :scale => 3
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_order_items", :force => true do |t|
    t.integer  "purchase_order_id"
    t.integer  "product_id",                                                  :default => 0
    t.decimal  "quantity",                     :precision => 12, :scale => 3, :default => 0.0
    t.decimal  "unit_price",                   :precision => 12, :scale => 3, :default => 0.0
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_id",                                                  :default => 0
    t.integer  "material_id",                                                                  :null => false
    t.integer  "currency_id"
    t.integer  "purchase_requisition_item_id",                                :default => 0
  end

  add_index "purchase_order_items", ["currency_id"], :name => "index_purchase_order_items_on_currency_id"
  add_index "purchase_order_items", ["material_id"], :name => "index_purchase_order_items_on_material_id"
  add_index "purchase_order_items", ["product_id"], :name => "index_purchase_order_items_on_product_id"
  add_index "purchase_order_items", ["project_id"], :name => "index_purchase_order_items_on_project_id"
  add_index "purchase_order_items", ["purchase_order_id"], :name => "index_purchase_order_items_on_purchase_order_id"
  add_index "purchase_order_items", ["purchase_requisition_item_id"], :name => "index_purchase_order_items_on_purchase_requisition_item_id"

  create_table "purchase_orders", :force => true do |t|
    t.date     "purchase_order_date"
    t.string   "purchase_order_number",   :limit => 12
    t.integer  "supplier_id"
    t.text     "remark"
    t.boolean  "void",                                  :default => false
    t.boolean  "settled",                               :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "deleted",                               :default => false
    t.integer  "purchase_requisition_id",               :default => 0,     :null => false
    t.boolean  "imported",                              :default => false
    t.string   "term",                    :limit => 45, :default => "0"
    t.string   "delivery_date",           :limit => 45
    t.integer  "project_id",                            :default => 0
    t.string   "deliver_to",              :limit => 45
    t.integer  "purchased_user_id",                     :default => 0
    t.integer  "approved_user_id",                      :default => 0
    t.integer  "currency_id",                           :default => 1
    t.date     "expected_delivery_date"
  end

  add_index "purchase_orders", ["approved_user_id"], :name => "index_purchase_orders_on_approved_user_id"
  add_index "purchase_orders", ["currency_id"], :name => "index_purchase_orders_on_currency_id"
  add_index "purchase_orders", ["imported"], :name => "index_purchase_orders_on_imported"
  add_index "purchase_orders", ["project_id"], :name => "index_purchase_orders_on_project_id"
  add_index "purchase_orders", ["purchased_user_id"], :name => "index_purchase_orders_on_purchased_user_id"
  add_index "purchase_orders", ["supplier_id"], :name => "index_purchase_orders_on_supplier_id"
  add_index "purchase_orders", ["term"], :name => "index_purchase_orders_on_term_id"

  create_table "purchase_requisition_categories", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_requisition_items", :force => true do |t|
    t.integer  "purchase_requisition_id"
    t.integer  "product_id",                                             :default => 0
    t.decimal  "quantity",                :precision => 12, :scale => 3, :default => 0.0
    t.decimal  "unit_price",              :precision => 12, :scale => 3, :default => 0.0
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "material_id",                                                               :null => false
    t.integer  "supplier_id",                                                               :null => false
    t.integer  "purchase_order_id",                                      :default => 0
    t.boolean  "confirmed",                                              :default => false, :null => false
    t.integer  "currency_id"
    t.decimal  "stock_quantity",          :precision => 12, :scale => 3, :default => 0.0
    t.decimal  "purchase_quantity",       :precision => 12, :scale => 3, :default => 0.0
    t.integer  "sequence_number",                                        :default => 0
  end

  add_index "purchase_requisition_items", ["currency_id"], :name => "index_purchase_requisition_items_on_currency_id"
  add_index "purchase_requisition_items", ["material_id"], :name => "index_purchase_requisition_items_on_material_id"
  add_index "purchase_requisition_items", ["product_id"], :name => "index_purchase_requisition_items_on_product_id"
  add_index "purchase_requisition_items", ["purchase_order_id"], :name => "index_purchase_requisition_items_on_purchase_order_id"
  add_index "purchase_requisition_items", ["purchase_requisition_id"], :name => "index_purchase_requisition_items_on_purchase_requisition_id"
  add_index "purchase_requisition_items", ["supplier_id"], :name => "index_purchase_requisition_items_on_supplier_id"

  create_table "purchase_requisitions", :force => true do |t|
    t.date     "pr_date"
    t.string   "pr_number",                        :limit => 12
    t.text     "remark"
    t.boolean  "void",                                           :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",                                     :default => 1
    t.boolean  "deleted",                                        :default => false
    t.integer  "issued_user_id",                                 :default => 0
    t.integer  "approved_user_id",                               :default => 6
    t.string   "batch_no",                         :limit => 45
    t.integer  "purchase_requisition_category_id",               :default => 0,     :null => false
    t.integer  "status_id",                        :limit => 1,  :default => 0,     :null => false
    t.string   "delivery_date",                    :limit => 45
    t.integer  "project_id"
    t.integer  "currency_id",                                    :default => 1
    t.date     "expected_delivery_date"
  end

  add_index "purchase_requisitions", ["approved_user_id"], :name => "index_purchase_requisitions_on_approved_user_id"
  add_index "purchase_requisitions", ["company_id"], :name => "index_purchase_invoices_on_company_id"
  add_index "purchase_requisitions", ["currency_id"], :name => "index_purchase_requisitions_on_currency_id"
  add_index "purchase_requisitions", ["issued_user_id"], :name => "index_purchase_requisitions_on_issued_user_id"
  add_index "purchase_requisitions", ["project_id"], :name => "index_purchase_requisitions_on_project_id"
  add_index "purchase_requisitions", ["purchase_requisition_category_id"], :name => "index_purchase_requisitions_on_purchase_requisition_category_id"

  create_table "report_categories", :force => true do |t|
    t.integer  "user_id"
    t.string   "name",       :limit => 45
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "report_category_items", :force => true do |t|
    t.integer  "report_category_id"
    t.integer  "product_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reserved_purchase_orders", :force => true do |t|
    t.string   "purchase_order_number", :limit => 10
    t.integer  "purchase_order_id",                   :default => 0
    t.boolean  "used",                                :default => false
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reserved_purchase_orders", ["purchase_order_id"], :name => "index_reserved_purchase_orders_on_purchase_order_id"

  create_table "return_note_items", :force => true do |t|
    t.integer  "return_note_id",                                        :default => 0
    t.integer  "project_id",                                            :default => 0
    t.integer  "product_id",                                            :default => 0
    t.integer  "material_id",                                           :default => 0
    t.decimal  "quantity",               :precision => 12, :scale => 3, :default => 0.0
    t.string   "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "purchase_order_item_id",                                :default => 0
  end

  add_index "return_note_items", ["material_id"], :name => "index_return_note_items_on_material_id"
  add_index "return_note_items", ["product_id"], :name => "index_return_note_items_on_product_id"
  add_index "return_note_items", ["project_id"], :name => "index_return_note_items_on_project_id"
  add_index "return_note_items", ["purchase_order_item_id"], :name => "index_return_note_items_on_purchase_order_item_id"
  add_index "return_note_items", ["return_note_id"], :name => "index_return_note_items_on_return_note_id"

  create_table "return_notes", :force => true do |t|
    t.string   "grn_number",     :limit => 20
    t.date     "grn_date"
    t.integer  "supplier_id",                  :default => 0,     :null => false
    t.string   "do_number"
    t.string   "serial_number",  :limit => 45
    t.string   "invoice_number"
    t.string   "remark"
    t.boolean  "void",                         :default => false
    t.boolean  "settled",                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "return_notes", ["supplier_id"], :name => "index_return_notes_on_supplier_id"

  create_table "salesmen", :force => true do |t|
    t.string   "name",          :limit => 45
    t.text     "address"
    t.string   "mobile_number", :limit => 12
    t.text     "remark"
    t.boolean  "suspend",                     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "ar_code"
    t.integer  "ar_last_number"
    t.string   "ap_code"
    t.integer  "ap_last_number"
    t.string   "invoice_code"
    t.integer  "invoice_last_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "purchase_requisition_code",        :limit => 10, :default => "PO"
    t.integer  "purchase_requisition_last_number",               :default => 10000
    t.date     "blowfish",                                       :default => '2009-12-15'
    t.string   "purchase_order_code",              :limit => 45, :default => "PO"
    t.integer  "purchase_order_last_number",                     :default => 10000
    t.string   "grn_code",                         :limit => 45, :default => "GRN"
    t.integer  "grn_last_number",                                :default => 10000
    t.string   "return_note_code",                               :default => "GRN"
    t.integer  "return_note_last_number",                        :default => 1000
    t.string   "company_name"
  end

  create_table "stock_adjustments", :force => true do |t|
    t.string   "name",              :limit => 45
    t.text     "description"
    t.integer  "store_location_id",                                              :default => 0
    t.integer  "product_id",                                                     :default => 0
    t.decimal  "quantity",                        :precision => 12, :scale => 3, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "debit",                                                          :default => true
  end

  create_table "stock_transfers", :force => true do |t|
    t.date     "transfer_date"
    t.integer  "product_id"
    t.integer  "from_store_location_id"
    t.integer  "store_location_id"
    t.integer  "quantity",               :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stocks", :force => true do |t|
    t.integer  "store_location_id"
    t.integer  "product_id"
    t.integer  "quantity",          :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "opening_balance",   :default => 0
  end

  add_index "stocks", ["product_id"], :name => "index_stocks_on_product_id"
  add_index "stocks", ["store_location_id"], :name => "index_stocks_on_store_location_id"

  create_table "store_locations", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_payments", :force => true do |t|
    t.date     "payment_date"
    t.integer  "supplier_id"
    t.string   "reference_number",  :limit => 20
    t.string   "resit_number",      :limit => 20
    t.text     "description"
    t.integer  "payment_method_id"
    t.decimal  "amount",                          :precision => 12, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supplier_payments", ["payment_method_id"], :name => "index_supplier_payments_on_payment_method_id"
  add_index "supplier_payments", ["supplier_id"], :name => "index_supplier_payments_on_supplier_id"

  create_table "suppliers", :force => true do |t|
    t.string   "code",           :limit => 45
    t.string   "name",           :limit => 100
    t.text     "address"
    t.string   "office_phone",   :limit => 45
    t.string   "fax_number",     :limit => 45
    t.string   "contact_person", :limit => 45
    t.string   "contact_number", :limit => 45
    t.boolean  "active",                                                       :default => true
    t.text     "remark"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",          :limit => 45
    t.decimal  "used_credit",                   :precision => 12, :scale => 2, :default => 0.0
    t.decimal  "paid_credit",                   :precision => 12, :scale => 2, :default => 0.0
    t.string   "area",           :limit => 45
    t.string   "term"
    t.string   "company_number", :limit => 45
  end

  create_table "terms", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transportation_slips", :force => true do |t|
    t.date     "transport_date"
    t.integer  "project_id",                                                        :default => 0
    t.integer  "supplier_id",                                                                        :null => false
    t.integer  "vehicle_id",                                                                         :null => false
    t.string   "lorry_number",         :limit => 20
    t.string   "description_of_goods"
    t.decimal  "quantity",                           :precision => 12, :scale => 3, :default => 0.0
    t.string   "from_location",        :limit => 45
    t.string   "to_location",          :limit => 45
    t.string   "driver_name",          :limit => 45
    t.string   "driver_ic",            :limit => 20
    t.string   "checked_by",           :limit => 45
    t.string   "do_number",            :limit => 45
    t.decimal  "fee",                                :precision => 12, :scale => 3, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "from_address"
    t.text     "to_address"
  end

  create_table "uoms", :force => true do |t|
    t.string   "name",        :limit => 45
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "department_id"
    t.integer  "language",                      :default => 1
    t.string   "employee_number", :limit => 10, :default => "nil", :null => false
    t.string   "signature_name",  :limit => 45
  end

  add_index "users", ["department_id"], :name => "index_users_on_department_id"

  create_table "vehicles", :force => true do |t|
    t.string   "name",        :limit => 45
    t.string   "description"
    t.boolean  "disabled",                  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", :force => true do |t|
    t.integer  "versioned_id"
    t.string   "versioned_type"
    t.text     "changes"
    t.integer  "number"
    t.datetime "created_at"
  end

  add_index "versions", ["created_at"], :name => "index_versions_on_created_at"
  add_index "versions", ["number"], :name => "index_versions_on_number"
  add_index "versions", ["versioned_type", "versioned_id"], :name => "index_versions_on_versioned_type_and_versioned_id"

end
