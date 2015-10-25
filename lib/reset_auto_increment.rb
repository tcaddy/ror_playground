class ResetAutoIncrement

  def self.reset(table=nil)
    if table
      sql = nil
      case ActiveRecord::Base.connection.instance_variable_get("@config")[:adapter].to_s
        when 'sqlite3'
          sql = "delete from sqlite_sequence where name = '#{table}'"
        when 'mysql'
          sql = "ALTER TABLE `#{table}` auto_increment=1"
      end
      ActiveRecord::Base.connection.execute(sql) unless sql.nil?
    end
  end

end