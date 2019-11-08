module ValidationRegexps

  NAME_REGEX = /\A(?=.{2,50}$)([A-Za-zÀ-ÖØ-öø-ÿ]+[- ']?[A-Za-zÀ-ÖØ-öø-ÿ]+)+{,50}\z/
  USERNAME_REGEX = /\A(?=.{4,30}$)([A-Za-z0-9_](?:(?:[A-Za-z0-9_]|(?:\.(?!\.))){0,28}(?:[A-Za-z0-9_]))?)\z/

end