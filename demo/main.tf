import { # My WEB
  id = "sg-0b67246e1c40b3895"
  to = aws_security_group.web
}

import { # My SQL
  id = "sg-0e5bc7c5805fdb344"
  to = aws_security_group.sql
}


import { # WEB Server
  id = "i-0fd2e0d7ed0126e8a"
  to = aws_instance.web
}

import { # SQL Server
  id = "i-0d6f0dd5c31df256b"
  to = aws_instance.sql
}
