import configparser
import os


# 创建ConfigParser对象
config = configparser.ConfigParser()
path = os.path.join(os.path.dirname(__file__), 'config.ini')

# print(path)
# 读取配置文件
config.read(path)

use_llms = config.get('base', 'use_llms')
use_cache_file = config.get('base', 'use_cache_file')
# 获取settings部分的所有设置
# debug_mode = config.getboolean('settings', 'debug_mode')
zhipu_appkey = config.get('zhipu', 'zhipu_appkey')
zhipu_model = config.get('zhipu', 'zhipu_model')
zhipu_teamToken = config.get('zhipu', 'zhipu_teamToken')

deepseek_appkey = config.get('deepseek', 'deepseek_appkey')
deepseek_model = config.get('deepseek', 'deepseek_model')


