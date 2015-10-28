# reset auto increment counters in database for primary keys
class ResetAutoIncrement
  def self.reset(table = nil)
    if table
      sql = nil
      case ActiveRecord::Base.connection.instance_variable_get('@config')[:adapter].to_s
      when 'sqlite3'
        sql = "delete from sqlite_sequence where name = '#{table}'"
      when 'mysql'
        sql = "ALTER TABLE `#{table}` auto_increment=1"
      when 'postgresql'
        # assume primary key is :id
        sql = "ALTER SEQUENCE #{table}_id_seq RESTART WITH 1"
      else raise "Unknown database adapter: #{ActiveRecord::Base.connection.instance_variable_get('@config')[:adapter]}"
      end
      ActiveRecord::Base.connection.execute(sql) unless sql.nil?
    end
  end
end
