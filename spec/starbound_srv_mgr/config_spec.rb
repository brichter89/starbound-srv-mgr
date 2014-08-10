require 'starbound_srv_mgr/config'
require 'starbound_srv_mgr/exceptions'

describe StarboundSrvMgr::Config do
    CONFIG_FILE = __dir__ + '/files/test_config.yaml'

    # @var [StarboundSrvMgr::Config]
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

    it 'should rise an error if the config key does not exist' do
        expect { @config.get(:i_do_not_exist) }.to raise_error(StarboundSrvMgr::InvalidConfigKeyError)
    end

    it 'should not distinguish symbol from string key name' do
        bazinga = 'BAZINGA'
        config_hash_1 = { :bazinga => bazinga }
        config_hash_2 = { 'bazinga' => bazinga}

        config_1 = StarboundSrvMgr::Config.new(config_hash_1)
        config_2 = StarboundSrvMgr::Config.new(config_hash_2)

        # Note that config_1 gets initialized with a symbol and the request is a string
        # and vice versa for config_2.
        expect(config_1.get('bazinga')).to eql bazinga
        expect(config_2.get(:bazinga)).to eql bazinga
    end

    it 'should hold a copy of the given hash to prevent manipulation' do
        config_hash = { :bazinga => 'BAZINGA' }
        config = StarboundSrvMgr::Config.new(config_hash)

        # Manipulation
        config_hash[:bazinga] = 'BOOOOM'

        expect(config.get :bazinga).to eql 'BAZINGA'
    end

    it 'should rise an error if the config source is invalid' do
        expect { StarboundSrvMgr::Config.new(:i_am_invalid) }.to raise_error StarboundSrvMgr::InvalidConfigSourceError
    end

    it 'should rise an error if the config file does not exist' do
        expect { StarboundSrvMgr::Config.new(:i_am_invalid) }.to raise_error StarboundSrvMgr::InvalidConfigSourceError
    end
end
