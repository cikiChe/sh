# sh
this  is script with linux what can be to autocompate generate nginx's conf | 一键生成nginx多文件配置脚本
 
 # 使用环境
 Linux
 
 # 使用场景
 配置多个二级域名的时候,例如 ex.com,当你输入ex.com 后，这个工具可以自动生成一堆你配置好前缀的域名 例如api.ex.com,admin.ex.com
 
 # 代码工作目录
 nginx/conf/vhost
 
 # 为什么要用这个工具
 主要是本地开发时使用，每次都要改一堆域名配置（外包公司），麻烦
 
 如何使用？
 温馨提示：请先进入到你需要生成 nginx 的工作目录，然后在进行操作，比如我的工作目录为 nginx/conf/vhost
 
 第一步：打开 Linux
 第二步：bash make.sh
 第三步：根据提示进行操作
 第四步：ll -a 
 
 # 如果需要修改？
 修改文件内的 nums，这个是修改域名前缀的
