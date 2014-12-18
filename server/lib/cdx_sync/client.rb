class Client
  attr_accessor :public_key, :id

  def intitialize(id, public_key)
    @id = id
    @public_key = public_key
  end

  def validate!
    match = /\Assh-rsa AAAA[0-9A-Za-z\+\/]+[=]{0,3} (.+@.+)\Z/.match public_key
    raise "Public key #{public_key} is not valid" unless match
  end

  def authorized_keys(sync_dir, options)
   ssh_command = "#{options[:rrsync_location]} #{sync_dir.client_sync_path id}"
   "\ncommand=\"#{ssh_command}\",no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding #{public_key}"
 end

end