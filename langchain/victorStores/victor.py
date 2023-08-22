from langchain.document_loaders import TextLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores import Chroma
from sentence_transformers import SentenceTransformer
from langchain.embeddings.openai import OpenAIEmbeddings
import chromadb
# import onnxruntime
# print("ONNXRuntime Version:", onnxruntime.__version__)

# Load the document, split it into chunks, embed each chunk and load it into the vector store.
raw_documents = TextLoader('/Users/yy.inc/Downloads/AuthSDK.h').load()
# print(raw_documents)
text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
documents = text_splitter.split_documents(raw_documents)




model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')
embeddins = list()
documentTxts =list()
metaDatas = list()
ids =list()
for index,element in enumerate(documents):
    ids.append(f'{index}')
    documentTxts.append(element.page_content)
    metaDatas.append(element.metadata)
    embedding = model.encode(element.page_content).tolist()
    embeddins.append(embedding)
    print(f'{index} : {element}\n')

# db = Chroma.from_documents(documents, OpenAIEmbeddings())
# db = Chroma.from_texts(embeddingTexts)






dbclient = chromadb.Client()
try:
    collection = dbclient.get_collection("AuthSDK")
    # 如果成功获取集合，表示集合存在
    # print("Collection exists:", collection)
except ValueError:
    # 如果捕获到ValueError异常，表示集合不存在
    print("Collection does not exist,creating...")
    collection = dbclient.create_collection(name='AuthSDK')
    collection.add(
                      embeddings=embeddins,
                      documents=documentTxts,
                      metadatas=metaDatas,
                      ids=ids)

query = "登出功能都有哪些？"
queryembedding = model.encode(query).tolist()
results = collection.query(
    query_embeddings=[queryembedding],
    n_results=2
)

# docs = db.similarity_search(query)
rsp_ids =results['ids']
rsp_metadatas =results['metadatas']
rsp_documents =results['documents']
# for index,element in enumerate(rsp_documents):
#     index_str =  f'{index}'
#     print('index:{index_str} rsp_ids:{rsp_ids}')
#     if index_str in rsp_ids:
#         print(f'index_str:{index_str} "content:"{element}\n')
print(f'results.couter_hits:\n{results}')




# ['/**\n *  @brief 初始化SDK\n *\n *  @param appId      业务方申请的appId\n *  @param appKey     业务方申请的appKey\n *  @param terminalType   终端类型\n *  @param uid        凭证登录的uid\n *\n *  @return 成功: YES   失败: NO\n */\n- (BOOL)initUDBWithUid:(NSString *)appId appKey:(NSString *)appKey terminalType:(unsigned long long)terminalType uid:(NSNumber *)uid;\n\n/**\n *  @brief 初始化SDK\n *\n *  @param appId      业务方申请的appId\n *  @param appKey     业务方申请的appKey\n *  @param terminalType   终端类型\n *  @param thirdLogin 第三方登录信息\n *\n *  @return 成功: YES   失败: NO\n */\n- (BOOL)initUDBWithUid:(NSString *)appId appKey:(NSString *)appKey terminalType:(unsigned long long)terminalType thirdLogin:(AuthProtoThirdTokenLoginReq *)thirdLogin;\n\n/**\n * 设置请求头扩展字段，需要在初始化后，发起请求前调用\n */\n- (void)setHeaderExt:(NSDictionary *)ext;\n\n/**\n* 设置设备信息扩展字段，需要在初始化后，发起请求前调用\n*/\n- (void)setDeviceInfoExt:(NSDictionary *)ext;', '/**\n *  @brief 获取token\n *\n *  @param appid      appId\n *  @param encode     token的编码方式\n *\n */\n- (NSData *)getToken:(NSString *)appid encodeType:(EncodeType)encode;\n\n/**\n *  @brief 获取token\n *\n *  @param appid      appId\n *  @param encode     token的编码方式\n *  @param productId productId\n *\n */\n- (NSData *)getToken:(NSString *)appid encodeType:(EncodeType)encode productId:(NSString *)productId;\n\n/**\n *  @brief 获取token\n *\n *  @param passport   通行证\n *  @param appid      appId\n *  @param encode     token的编码方式\n *\n */\n- (NSData *)getTokenByPassport:(NSString *)passport appid:(NSString *)appid encodeType:(EncodeType)encode;\n\n/**\n *  @brief 获取webtoken\n */\n- (NSData *)getWebToken;\n\n/**\n *  @brief 登录成功后调用该方法来获取Ticket (用于连接信令)\n */\n- (NSData *)getTicket;\n\n/**\n *  @brief 获取yycookies\n */\n- (NSData *)getYYCookies;\n\n/**\n *  @brief 获取一次性使用凭证\n *\n *  @param appid    appId\n */\n- (NSData *)getOTP:(NSString *)appid;']
