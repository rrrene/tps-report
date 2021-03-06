Reports - Excel friendly for your clients, bosses and the rest of us
============================

Report-Objects basically format arrays for CSV output

Introduction
------------

The following examples all result in the same output:

### Rails

    users = User.all
    Report.new(users)

This would list all attributes of the ActiveRecord objects.
If one wants to restrict the output, one can use the :fields parameter:

    Report.new(users, :fields => %w(login email occupation))

### Hash

    user_hashes = [
      {:login => 'brian', :email => 'brian@example.com', :occupation => 'Coder'},
      {:login => 'steve', :email => 'steve@example.com', :occupation => 'Designer'},
      {:login => 'melinda', :email => 'melinda@example.com', :occupation => 'Product Guru'},
    ]
    Report.new(user_hashes)

### Array of Arrays

    user_arrays = [
      ['brian', 'brian@example.com', 'Coder'},
      ['steve', 'steve@example.com', 'Designer'},
      ['melinda', 'melinda@example.com', 'Product Guru'},
    ]
    Report.new(user_arrays)

To fill the first line in this example, you can use the :fields parameter:

    Report.new(users, :fields => %w(login email occupation))

Inheritance
-----------

By creating a class which inherits from Report you can create specialized
reports and the fields parameter can be specified class-wide.

    class UserReport < Report
      fields :email, :login
    end

This has the exact same effect as if you create it this way:
  Report.new(user_arrays, :fields => [:email, :login])

The fields parameter doesnot only take strings and symbols, but also other
objects who respond to a 'fields' method.

So you could have a hash of users (see above) and tell the report to format
it like your regular user reports by writing:

    Report.new(user_hashes, :fields => UserReport)

This will give the login and email of each user in the hash. If you still
want to include the occupation field, you can:

    Report.new(user_hashes, :fields => [UserReport, :occupation])

