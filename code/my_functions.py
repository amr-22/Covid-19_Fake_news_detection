import re
import requests
from tqdm import tqdm



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
    text=remove_urls(text)
    text=extract_hashtag(text)
    text=extract_mention(text)
    text=remove_emoji(text)
    text=remove_symbols(text)
    text=remove_space(text)
    return(text)



def url_short_to_long(url_text):
    """ -- convert short url to long url """
    site = requests.get(url_text)
    return site.url



def count_of_text(text,dataset):
    """ -- return count of text in dataset that added """
    count=0

    for x in tqdm(range(len(dataset))):
        if text in dataset.tweet[x]:
            count+=1
            
    return count

























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