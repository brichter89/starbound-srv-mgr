require 'starbound_srv_mgr/config'

describe StarboundSrvMgr::Config do
    CONFIG_FILE = __dir__ + '/files/test_config.yaml'

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

    it 'should return the value of a config key' do
        expect(@config.get :bazinga).to eql 'BAZINGA'
        expect(@config.get :Day_of_German_Unity).to eql Date.new(1990, 10, 3)
        expect(@config.get :radius_of_earth_km).to eql 6371
        expect(@config.get :enable_gravity).to be true
        expect(@config.get :π).to eql Math::PI
    end
end
