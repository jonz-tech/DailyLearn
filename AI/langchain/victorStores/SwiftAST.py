import subprocess
import json
import os
import re
from collections import defaultdict
system_lib_path = "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk/System/Library/Frameworks/"
# 设置其他环境变量（可选）
other_env_vars = {
    # "SWIFT_EXEC": "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc",  # 设置 swiftc 可执行文件路径
    # "LD_LIBRARY_PATH": "/path/to/library"  # 设置其他可能需要的库路径
}



# 调用 Swift 命令行工具并获取 JSON AST 内容
class SwiftASTTextParser(object):
    def __init__(self):
        self.resetVar()

    def resetVar(self):
        self.filePath = None
        self.fileContent = None
        self.fileBaseName = None
        self.textTrunks = None

    def generate_ast(self,swift_code):
        command = ["swiftc", "-dump-ast", "-"]
        process = subprocess.Popen(command, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        stdout, stderr = process.communicate(input=swift_code)
        return stdout
    
    def __clangTextFile__(self, filepath=''):
        self.resetVar()
        if filepath == '':
            return
        self.filePath = filepath
        self.fileBaseName = os.path.basename(self.filePath)
        with open(self.filePath, 'r') as file:
            self.fileContent = file.read()  # 读取文件内容
            file.close()
    def isValidJson(self,json_str):
        try:
            json.loads(json_str)
            return True
        except json.JSONDecodeError:
            return False
        
    def re_mach_decl(self, decls=['import_decl', 'var_decl', 'class_decl'], input_text=''):
        # 使用正则表达式匹配信息
        if len(decls) >= 0:
            exp = '|'.join(decls)
        rexp = f"({exp}) range=\[.*:(\d+):(\d+) - line:(\d+):(\d+)\]"
        # 定义正则表达式模式
        pattern = rf"{rexp}"

        # 使用正则表达式匹配信息
        matches = re.findall(pattern, input_text)

        for match in matches:
            declaration_type, start_line, start_col, end_line, end_col,name = match
            if declaration_type in decls:
                print(f'match: {name},line:{start_line},col:{start_col},type:{type}')
                return (True, name, (start_line, end_line))
            else:
                continue
        
        return (False, (None, None))

    def astToJson(self,astcontent):
        ast_dict = defaultdict(list)
        current_node = None
        CLASS_PROTOCOL_KEYS = ['class_decl','extension_decl']
        NODE_NAME_KEYS =['import_decl','var_decl']
        NODE_RANG_KEYS =['import_decl','top_level_code_decl','pattern_binding_decl']
        allkeys = CLASS_PROTOCOL_KEYS + NODE_NAME_KEYS + NODE_RANG_KEYS
        allkeys = list(set(allkeys))
        class_protocal_name = None
        class_protocla_range = None
        for line in astcontent.split('\n'):
            # print(f"{line}")
            # 隐射声明忽略 的结构
            if 'implicit' in line: 
                continue

            for key in allkeys:
                if key in line:
                    import_parse = self.re_mach_decl(decls=allkeys,input_text=line.strip())
                    if import_parse[0] == True:
                        class_protocal = import_parse[1]
                        class_protocla_range = import_parse[2]
                    else:
                        print(f"{line}")
                    break

           

        # 将解析后的字典转换为 JSON 格式
        json_output = json.dumps(ast_dict, indent=4)
        return json_output
        # print(json_output)

    def writeTxt(self,content):
        file_path = "./parse.txt"
        with open(file_path, "w") as file:
            file.write(f"{content}\n")

    def getTextTrunck(self,filePath=''):
        self.__clangTextFile__(filePath)
        if len(self.fileContent) <= 0:
            return
        # 调用函数生成 JSON AST 内容
        ast = self.generate_ast(self.fileContent)

        # return
        self.writeTxt(ast)
        jsoncontent = self.astToJson(ast)
        return
        if self.isValidJson(jsoncontent) == False:
            print(f'json {jsoncontent} is invaild')
            return
        
        # 解析 JSON 内容
        ast_data = json.loads(jsoncontent)
        # 打印 JSON AST 内容
        print(json.dumps(ast_data, indent=4))

instance = SwiftASTTextParser()
instance.getTextTrunck('/Users/yy.inc/Downloads/LinkMicUserViewCell.swift')