print("init here")
vim.env.JAVA_HOME = "/usr/lib/jvm/java-24-graalvm"
vim.env.PATH = vim.env.JAVA_HOME .. "/bin:" .. vim.env.PATH
require("config.lazy")
require("config.settings")
