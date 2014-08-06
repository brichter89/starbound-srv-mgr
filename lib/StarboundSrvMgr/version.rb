module StarboundSrvMgr
=begin

    Versioning
    ----------

    - `<major>.<minor>[.<patch>][[.<a|b|rc><nr>]|.dev]`
    - Version `0.x.x` are incomplete and under development
    - `1.0.0` is the first stable release
    - Before releasing stable versions there are alpha
      versions `<version>.a1` etc, and beta versions `<version>.b1` etc.
    - A release candidate is marked as `<version>.rc1` ect.
    - `<version>.dev` is a development version. It MUST NOT be tagged
      but the version file should contain the `.dev` suffix unless the
      next commit will be released / tagged. After tagging, the `.dev`
      must be added again to the version string to indicate an unstable
      *dev-state*.
    - While there is not any functionality, before the first version
      tagging the version file contains `0.0.0`

=end
    VERSION = '0.0.0'
end
