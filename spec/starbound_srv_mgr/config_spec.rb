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
        expect(@config.get :superheroes).to be_an Array
        expect(@config.get :chemical_elements).to be_a Hash
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

    it 'should hold a clone of the given hash to prevent manipulation' do
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

    it 'should return the whole config hash if requested key is \'::\'' do
        config = @config.get('::')
        expect(config).to be_a Hash
        expect(config[:bazinga]).to eql 'BAZINGA'
    end

    it 'should return a clone of the whole config hash if requested key is \'::\' to prevent manipulation' do
        # Manipulation
        @config.get('::')[:bazinga] = 'BOOOOM'

        expect(@config.get('::')[:bazinga]).to eql 'BAZINGA'
    end

    it 'should have an alias for #get(\'::\') named #getAll()' do
        config = @config.get_all
        expect(config).to be_a Hash
        expect(config[:bazinga]).to eql 'BAZINGA'
    end

    it 'should accept a default value as fallback' do
        expect(@config.get :i_do_not_exist, 'but f@½# that, im here anyways').to eql 'but f@½# that, im here anyways'
    end

    it 'should convert all string hash keys to symbols' do
        expect(@config.get_all.has_key? 'bazinga').to be false
        expect(@config.get_all.has_key? :bazinga).to be true
        expect(@config.get(:these_keys_should_be).has_key? :symbols).to be true
        expect(@config.get(:these_keys_should_be)[:symbols].has_key? :sym1).to be true
        expect(@config.get(:these_keys_should_be)[:hybrid].has_key? :sym).to be true
    end

    it 'should not convert numeric hash or array keys to symbols' do
        expect(@config.get(:these_keys_should_be)[:numeric_1]).to be_an Hash
        expect(@config.get(:these_keys_should_be)[:numeric_1].has_key? 10).to be true
        expect(@config.get(:these_keys_should_be)[:numeric_2]).to be_an Array
        expect(@config.get(:these_keys_should_be)[:hybrid].has_key? 1337).to be true
    end
end
