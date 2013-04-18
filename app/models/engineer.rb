class Engineer
  #gem install rubyzip, nokogiri, spreadsheet, google-spreadsheet, spreadsheet-excel
  #apt-get install libxslt1-dev
  require 'roo'

  def self.check_supplier
    Supplier.all.each do |s|
      #s.contact_number = s.contact_number.to_s.insert(0, "0") if s.contact_number[0,1].to_s != "0"  unless s.contact_number.nil? || s.contact_number.blank?
      #s.office_phone = s.office_phone.to_s.insert(0, "0") if s.office_phone[0,1].to_s != "0" unless s.office_phone.nil? || s.office_phone.blank?
      #s.fax_number = s.fax_number.to_s.insert(0, "0") if s.fax_number[0,1].to_s != "0" unless s.fax_number.nil? || s.fax_number.blank?
      s.contact_number = s.contact_number[0,s.contact_number.length - 2]  if s.contact_number[-2,2].to_s == ".0" unless s.contact_number.nil? || s.contact_number.blank?
      s.office_phone = s.office_phone[0,s.office_phone .length - 2]  if s.office_phone[-2,2].to_s == ".0" unless s.office_phone.nil? || s.office_phone.blank?
      s.fax_number = s.fax_number[0,s.fax_number.length - 2]  if s.fax_number[-2,2].to_s == ".0" unless s.fax_number.nil? || s.fax_number.blank?
      s.save(false)
    end
    
  end

  def self.import_supplier
    
    file = RAILS_ROOT + "/public/supplier.xlsx"
    oo = Excelx.new(file)
    oo.default_sheet = oo.sheets.first
     2.upto(oo.last_row) do |line|
      code       = oo.cell(line,'B')
      name       = oo.cell(line,'C')
      address    = oo.cell(line,'D')
      contact    = oo.cell(line,'E')
      phone      = oo.cell(line,'F')
      phone2     = oo.cell(line,'G')
      fax        = oo.cell(line,'H')
      hp         = oo.cell(line,'I')
      hp2        = oo.cell(line,'J')
      email      = oo.cell(line,'K')
      term       = oo.cell(line,'L')

      
      sup = Supplier.new
      sup.code = code
      sup.name = name
      sup.address = address
      sup.contact_person = contact
      if phone.nil? or phone.to_s.downcase == "nil"
        unless phone2.nil? or phone2.to_s.downcase == "nil"
          result_phone = phone2
        end
      else
        result_phone = phone.to_s + "-" + phone2.to_s
      end

      if hp.nil? or hp.to_s.downcase == "nil"
        unless hp2.nil? or hp2.to_s.downcase == "nil"
          result_hp = hp2
        end
      else
        result_hp = hp.to_s + "-" + hp2.to_s
      end
      sup.contact_number = result_hp
      sup.office_phone = result_phone
      sup.fax_number = fax
      sup.email = email
      sup.term = term.strip unless term.nil?
      sup.save!
    end

  end

  def self.import_material
    file = RAILS_ROOT + "/public/materials.xlsx"
    oo = Excelx.new(file)
    oo.default_sheet = oo.sheets.first
    2.upto(oo.last_row) do |line|
      
      code       = oo.cell(line,'B')
      category      = oo.cell(line,'C')
      name       = oo.cell(line,'D')
      uom   = oo.cell(line,'E')
      remark   = oo.cell(line,'F')
    if code
      p = Material.new
      p.code = code
      p.description = name
      p.material_category = MaterialCategory.find_or_create_by_name(category.upcase) if category
      p.uom = Uom.find_or_create_by_name(uom.upcase) if uom
      p.remark = remark

      p.save!
    end
    end
  end

  def self.import_po_history
    file = RAILS_ROOT + "/public/PO.xlsx"
    oo = Excelx.new(file)
    oo.default_sheet = oo.sheets.first
    2.upto(oo.last_row) do |line|
      id            = oo.cell(line,'A')
      year          = oo.cell(line,'B')
      month         = oo.cell(line,'C')
      delivery_date = oo.cell(line,'D')
      pr_no         = oo.cell(line,'E')
      po_no         = oo.cell(line,'F')
      project_code  = oo.cell(line,'G')
      po_issue_date = oo.cell(line,'H')
      supplier_code = oo.cell(line,'I')
      material_code = oo.cell(line,'J')
      category      = oo.cell(line,'K')
      item_desc     = oo.cell(line,'L')
      uom           = oo.cell(line,'M')
      remark        = oo.cell(line,'N')
      unit_price    = oo.cell(line,'O')
      qty           = oo.cell(line,'P')
      deliver_to    = oo.cell(line,'Q')
      term          = oo.cell(line,'R')
      product_code  = oo.cell(line,'S')
      currency      = oo.cell(line,'T')
      currency_price = oo.cell(line,'U')

      p = PurchaseOrderHistory.new
      p.history_id = id
      p.year = year
      p.month = month
      p.delivery_date = delivery_date
      p.pr_number = pr_no
      p.po_number = po_no
      p.project_code = project_code
      p.po_issue_date = po_issue_date
      p.supplier_code = supplier_code
      p.material_code = material_code
      p.category = category
      p.item_description = item_desc
      p.uom = uom
      p.remark = remark
      p.unit_price = unit_price
      p.qty = qty
      p.deliver_to = deliver_to
      p.term = term
      p.product_code = product_code
      p.currency = currency
      p.currency_unit_price = currency_price

      p.save!
    end
    puts "Done"
  end

  
  
end
