require 'StarboundSrvMgr/config'

describe StarboundSrvMgr::Config do
    CONFIG_FILE = __dir__ + '/files/testConfig.yaml'

    # @var StarboundSrvMgr::Config
    @config

    before :each do |example|
        unless example.metadata[:skip_before]
            @config = StarboundSrvMgr::Config.new(CONFIG_FILE)
        end
    end

    it 'should accept a yaml config file', :skip_before do
        config = StarboundSrvMgr::Config.new(CONFIG_FILE)

        expect(config).to be_instance_of StarboundSrvMgr::Config
    end

    it 'should accept a config hash', :skip_before do
        config_hash = {}
        config = StarboundSrvMgr::Config.new(config_hash)

        expect(config).to be_instance_of StarboundSrvMgr::Config
    end
end
