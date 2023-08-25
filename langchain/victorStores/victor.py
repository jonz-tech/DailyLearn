from langchain.document_loaders import TextLoader
from langchain.text_splitter import CharacterTextSplitter
from langchain.vectorstores import Chroma
from sentence_transformers import SentenceTransformer
from langchain.embeddings.openai import OpenAIEmbeddings
import chromadb
from ObjcASTTextSplitter import ObjcTextSplitter,ObjecTextMeta

sourcefilepath = '/Users/yy.inc/Downloads/AuthSDK.h'

# exit(0)
# import onnxruntime
# print("ONNXRuntime Version:", onnxruntime.__version__)

# Load the document, split it into chunks, embed each chunk and load it into the vector store.
# raw_documents = TextLoader('/Users/yy.inc/Downloads/AuthSDK.h').load()
# text_splitter = CharacterTextSplitter(chunk_size=1000, chunk_overlap=0)
# documents = text_splitter.split_documents(raw_documents)
# exit(0)

model = SentenceTransformer('sentence-transformers/all-MiniLM-L6-v2')

dbclient = chromadb.Client()
try:
    collection = dbclient.get_collection("AuthSDK")
    # 如果成功获取集合，表示集合存在
    # print("Collection exists:", collection)
except ValueError:
    # 如果捕获到ValueError异常，表示集合不存在
    print("Collection does not exist,creating...")
    collection = dbclient.create_collection(name='AuthSDK')
    embeddins = list()
    documentTxts = list()
    metaDatas = list()
    ids =list()

    instance = ObjcTextSplitter()
    documents = instance.getTextTrunck(sourcefilepath)
    for index,element in enumerate(documents):
        ids.append(f'{index}')
        kind = element.codekind if element.codekind is not None else ''
        raw_comments = element.raw_comments if element.raw_comments is not None else ''
        content = f'[{element.basefilename}][{element.codeRage}][{kind}]\n{raw_comments}\n{element.codeContent}'
        # print(f'index:{index} \n {content}')
        documentTxts.append(content)
        metaDatas.append({'file':element.filepath})
        embedding = model.encode(content).tolist()
        embeddins.append(embedding)
    collection.add(
                      embeddings=embeddins,
                      documents=documentTxts,
                      metadatas=metaDatas,
                      ids=ids)

query = "我想了解一下怎么打日志"
queryembedding = model.encode(query).tolist()
results = collection.query(
    query_embeddings=[queryembedding],
    n_results=2
)

# docs = db.similarity_search(query)
rsp_ids =results['ids']
rsp_distances =results['distances']
rsp_metadatas =results['metadatas']
rsp_documents =results['documents']
for index,element in enumerate(rsp_documents[0]):
    index_str =  f'{index}'
    # print('index:{index_str} rsp_ids:{rsp_ids}')
    # if index_str in rsp_ids:
    metafile = rsp_metadatas[0][index]['file']
    print(f'\n======== index: {rsp_ids[0][index]} | distance:[{rsp_distances[0][index]}] \n{metafile}\n{element}\n')
# print(f'results.couter_hits:\n{results}')


