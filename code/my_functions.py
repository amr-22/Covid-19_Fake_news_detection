import re
import requests
from tqdm import tqdm
import pandas as pd



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

def find_url(text):
    url = re.findall('https?://(?:[-\w.]|(?:%[\da-fA-F]{2}))+/.*', text)
    return url
    

def urls_in_dateset(dataset):
    long_urls_link=[]
    count=0
    for line in dataset["tweet"]:
                count+=1
                urls = find_url(line)
                for url in urls:
                        x = requests.get(url)
                        long_urls_link.append(x.url)
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