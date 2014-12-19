module CDXSync
  class AuthorizedKeys
    attr_accessor :path #TODO default path for authorizedkeys

    def initialize(path)
      @path = path
    end

    def append_authorized_keys!(clients, sync_dir)
      open_and_write 'a', clients, sync_dir
    end

    def write_authorized_keys!(clients, sync_dir)
      open_and_write 'w', clients, sync_dir
    end

    private

    def open_and_write(mode, clients, sync_dir)
      keys = authorized_keys_for(clients, sync_dir).join("\n")
      keys = "\n" + keys if mode == 'a'
      File.open(path, mode) do |file|
        file << keys
      end
    end

    def authorized_keys_for(clients, sync_dir)
      clients.map do |client|
        client.validate!
        client.authorized_keys_entry(sync_dir)
      end
    end
  end
end