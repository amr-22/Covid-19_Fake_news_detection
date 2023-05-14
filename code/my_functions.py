import re
import requests
from tqdm import tqdm
import pandas as pd
import numpy as np
from nltk import tokenize, word_tokenize
from nltk.tokenize import word_tokenize, sent_tokenize
import nltk 

from bs4 import BeautifulSoup



# function for remove url
def remove_urls (text):
    text = re.sub(r'(https|http)?:\/\/(\w|\.|\/|\?|\=|\&|\%)*\b', '', text, flags=re.MULTILINE)
    return(text)


# function for remove hashtag
def extract_hashtag(text):
    text=re.sub("#[a-zA-Z0-9_]+","",text)
    return(text)
    
    
# function for remove mentions    
def extract_mention(text):
    text=re.sub("@[a-zA-Z0-9_]+","",text)
    return(text)
    
def remove_space(text):
    text=re.sub('\s+'," ",text)
    # text=re.sub('  +'," ",text)
    return(text)  


def remove_symbols(text):
    # text=re.sub('\?\?'," ",text)
    text=re.sub("[\?\!]"," ",text)
    return(text)   



def remove_emoji(text):
    text=re.sub("[\U0001F600-\U0001F64F\U0001F300-\U0001F5FF\u2705\uFFFD]","",text)

    return text

def remove_useless_tokens(text):
    '''
    removing all off next parts in one time
     - remove_urls
     - extract_hashtag
     - extract_mention
     - remove_emoji
     - remove_symbols
     - remove_space
    '''
    text=remove_urls(text)
    text=extract_hashtag(text)
    text=extract_mention(text)
    text=remove_emoji(text)
    text=remove_symbols(text)
    text=remove_space(text)
    return(text)



def url_short_to_long(url_text):
    """ -- convert short url to long url """
    headers = {
     'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/68.0.3440.106 Safari/537.36',
    }
    site = requests.get(url_text,headers=headers)
    return site.url



def count_of_text(text,dataset):
    """ -- return count of text in dataset that added """
    count=0

    for x in tqdm(range(len(dataset))):
        if text in dataset.tweet[x]:
            count+=1
            
    return count

def find_url(text):
    # url = re.findall('https?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+/.*', text)
    url = re.findall(r'(https|http)?:\/\/(\w|\.|\/|\?|\=|\&|\%)*\b', text)
    return url
    
    
from urlextract import URLExtract

def urls_in_dateset(dataset):
    long_urls_link=[]
    count=0
    extractor = URLExtract()
    for line in dataset["tweet"]:
                count+=1
                urls = find_url(line)
                urls = extractor.find_urls(urls)
                print("------> " + urls)
                for url in urls:
                    
                        print("______________________________")
                        # url = extractor.find_urls(line)
                        url = re.sub("[.$]","",url)
                        # x = requests.get(url)
                        long_urls_link.append(url)
    return long_urls_link






def hashtag_list(dataset):
    hashtag_list=[]

    for line in dataset["tweet"]:
        hashtags=re.findall(r'\B#\w*[a-zA-Z]+\w*',line)
        for hashtag in hashtags:
            hashtag_list.append(hashtag)
    
    hashtag_list=[*set(hashtag_list)]
    return hashtag_list




from selenium import webdriver
from selenium.webdriver import *
from selenium.webdriver.common.by import By
#get twitter content and user name

def twitter_get_data(url):
    browser = webdriver.Chrome()
    browser.get(url)
    twit_name=browser.find_element(By.XPATH,'/html/body/div[1]/div/div/div[2]/main/div/div/div/div/div/section/div/div/div[1]/div/div/div/article/div/div/div/div[2]/div[2]/div/div/div/div[1]/div/div/div[2]/div/div/a').text
    twit_content = browser.find_element(By.XPATH,'/html/body/div[1]/div/div/div[2]/main/div/div/div/div/div/section/div/div/div[1]/div/div/div/article/div/div/div/div[3]/div[2]/div/div/span').text
    check_twitter_usenme("twit_name")
    # chec twitter user name from collected lists 

twitter_fake_list=['@NewscheckerIn']
twitter_real_list=['@MOHFW_INDIA','@SkyNews','@WHO']

def check_twitter_usenme(twit_name):
        if twit_name in twitter_fake_list:
            result = 'fake'
            return (result)
        elif twit_name in twitter_real_list:
            result='real'
            return (result)
        else:
            result='null'
            return (result)



########################################################
#################    remove stopWords   ################
########################################################
import spacy    
nlp = spacy.load('en_core_web_sm')   
filtered_sentence=[]
def remove_stop_wordds(text):
    customize_stop_words = [    ]
    customize_not_stop_words = [    ]
    for w in customize_stop_words:
        nlp.Defaults.stop_words.add(w)
        nlp.vocab[w].is_stop = True    
    for w in customize_stop_words:
        nlp.Defaults.stop_words.remove(w)
        customize_not_stop_words = False
    for w in text:
        if w.is_stop == False:
            filtered_sentence.append(w)




########################################################
#################    find similarity    ################
########################################################

def sim_values_between_token_and_sites(url,tweet):
    '''
      this function to find similarity between tokens of data in site and tokens of tweet
      ---------------------------------------
       return:-
       - sumValues
       - count 
    '''
    # work with url
    request=requests.get(url)
    soup = BeautifulSoup(request.text, "html.parser")
    text1=soup.body.get_text()
    words = word_tokenize(text1)
    stopwords = nltk.corpus.stopwords.words('english')
    
    siteFreqTable = dict()
    for word in words:
        word = word.lower()
        if word in stopwords:
            continue
        if word in siteFreqTable:
            siteFreqTable[word] += 1
        else:
            siteFreqTable[word] = 1
            
         
    # work with tweet
       
    tweet_tokenized= word_tokenize(tweet)  
    tweetFreqTable = dict()
    for word in tweet_tokenized:
        word = word.lower()
        if word in stopwords:
            continue
        if word in tweetFreqTable:
            tweetFreqTable[word] += 1
        else:
            tweetFreqTable[word] = 1
            
    # calculations

    sumValues=0
    count=0

    for token in tweetFreqTable:
        if token in siteFreqTable:
            count+=1
            sumValues+=siteFreqTable[token]/len(siteFreqTable)
    
    return sumValues,count



################################################## new #########################################################
########################################################
##############   model for similarity   ################
########################################################
###pip install sentence_transformers
from sentence_transformers import SentenceTransformer, util
model = SentenceTransformer('all-MiniLM-L6-v2')
# Two lists of sentences
sentences1 = [tweet]
sentences2 = [doc_data]
#Compute embedding for both lists
embeddings1 = model.encode(sentences1, convert_to_tensor=True)
embeddings2 = model.encode(sentences2, convert_to_tensor=True)
#Compute cosine-similarities
cosine_scores = util.cos_sim(embeddings1, embeddings2)
#Output the pairs with their score
for i in range(len(sentences1)):
   print( cosine_scores[i][i])

########################
########################################################
#################    find similarity    ################
########################################################
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.metrics.pairwise import cosine_similarity

# Example document and query
document =doc_data
query = tweet

# Preprocess the text
document = document.lower()
query = query.lower()

# Convert text to numerical vectors using bag-of-words model
vectorizer = CountVectorizer().fit_transform([document, query])
document_vector, query_vector = vectorizer.toarray()

# Calculate cosine similarity
similarity = cosine_similarity([document_vector], [query_vector])
print(similarity[0][0])  # prints the cosine similarity score
##################################################################################################################











# def count_of_text_in_real_&_fake(text):
    
#     real_count=0
#     fake_count=0
#     for x in tqdm(range(len(fake_data))):
#         if text in fake_data.tweet[x]:
#             fake_count+=1
            
#     for x in tqdm(range(len(real_data))):
#         if text in real_data.tweet[x]:
#             real_count+=1


#     print("count of "+ text+" in fake data ----> "+ str(fake_count))
#     print("count of "+ text+" in fake data ----> "+str(real_count))