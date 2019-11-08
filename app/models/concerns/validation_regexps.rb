module ValidationRegexps

  NAME_REGEXP = /\A(?=.{2,50}$)([A-Za-zÀ-ÖØ-öø-ÿ]+[- ']?[A-Za-zÀ-ÖØ-öø-ÿ]+)+{,50}\z/
  USERNAME_REGEXP = /\A(?=.{4,30}$)([A-Za-z0-9_](?:(?:[A-Za-z0-9_]|(?:\.(?!\.))){0,28}(?:[A-Za-z0-9_]))?)\z/
  PASSWORD_REGEXP = /\A(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&^£\$`'<>])[A-Za-z\d@$!%*#?&^£\$`'<>]{8,}\z/

end