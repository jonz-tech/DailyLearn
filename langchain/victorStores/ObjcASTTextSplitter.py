import clang
from clang.cindex import Index
import clang.cindex
from clang.cindex import Config
from clang.cindex import CursorKind
import os
libpath = '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/'
Config.set_library_path(libpath)
# Config.set_library_file(f'{libpath}/libclang.dylib')

class ObjecTextMeta(object):
    def  __init__(self):
        self.basefilename = None
        self.filepath = None
        self.codeRage = None
        self.codeContent = None
        self.raw_comments = None
        self.codekind = None
        

class ObjcTextSplitter(object):
    def __init__(self):
        self.resetVar()

    def resetVar(self):
        self.filepath = None
        self.fileContent = None
        self.filebasename = None
        self.textTrunks = []

    def __clangTextFile__(self, filepath=''):
        self.resetVar()
        if filepath == '':
            return
        self.filepath = filepath
        self.filebasename = os.path.basename(self.filepath)
        with open(self.filepath, 'r') as file:
            self.fileContent = file.read()  # 读取文件内容
            file.close()

    def deduplicationData(self, arrays=[]):
        uniqueKeys = set()
        unique_list = []
        for element in arrays:
            # print(f"Checking element with codeRage: {element.codeRage}")
            
            if element.codeRage not in uniqueKeys:
                uniqueKeys.add(element.codeRage)
                unique_list.append(element)
        return unique_list

        

    def getTextTrunck(self,filepath=''):
        self.__clangTextFile__(filepath)

        if len(self.filepath) <= 0:
            return self.textTrunks

        if len(self.fileContent) <= 0:
            return self.textTrunks

        index = clang.cindex.Index.create()
        translation_unit = index.parse(self.filepath, args=['-x', 'objective-c', '-fobjc-arc'])

        if not translation_unit:
            print("Failed to parse the file.")
            return self.textTrunks

        self.textTrunks.extend(self.traverse(translation_unit.cursor))
        # 去重 
        # count1 = len(self.fileContent)
        rn = self.deduplicationData(arrays=self.textTrunks)
        self.textTrunks = []
        self.textTrunks.extend(rn)
        # count2 = len(self.fileContent)

        # print(f'count1:{count1} count2:{count2} \n'))
        return rn

    def traverse(self, node, class_protocal=''):
        result_list = []
        source_text = ''
        if node.kind == clang.cindex.CursorKind.OBJC_INTERFACE_DECL or node.kind == clang.cindex.CursorKind.OBJC_PROTOCOL_DECL or node.kind == clang.cindex.CursorKind.OBJC_CATEGORY_DECL:
            class_protocal = f'{node.spelling}'

        if node.kind == CursorKind.OBJC_INSTANCE_METHOD_DECL or node.kind == CursorKind.ENUM_DECL or node.kind == CursorKind.OBJC_CLASS_METHOD_DECL:
            startline = node.extent.start.line
            startcloumn = node.extent.start.column
            endline = node.extent.end.line
            endcloumn = node.extent.end.column
            lines = self.fileContent.splitlines()
            # if node.kind == CursorKind.OBJC_INSTANCE_METHOD_DECL:
            #     print(f'{source_text}')
            # if node.raw_comment is not None: # 如果有注释
                # source_text +=  node.raw_comment+'\n'

            for index,line in enumerate(lines):
                realIndex = index+1
                if realIndex >= startline and realIndex <= endline:
                    source_text += line
                if realIndex >= endline:
                    break
            # print(f'[{self.filebasename}][{startline}:{endline}][{class_protocal}]\n{source_text}\n')
            node_meta = ObjecTextMeta()
            node_meta.basefilename = self.filebasename
            node_meta.filepath = self.filepath
            node_meta.codeRage = f'[{startline}:{endline}]'
            node_meta.codeContent = source_text
            node_meta.raw_comments = node.raw_comment
            node_meta.codekind = class_protocal
            result_list.append(node_meta)

        # print('  ' * depth + f"{node.kind} - {node.spelling}")
    
        for child in node.get_children():
            rn_list = self.traverse(child,class_protocal)
            result_list.extend(rn_list)

        return result_list
