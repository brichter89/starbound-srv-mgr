module StarboundSrvMgr
    class Error < RuntimeError; end
    class InvalidConfigSourceError < Error; end
    class InvalidConfigKeyError < Error; end
end