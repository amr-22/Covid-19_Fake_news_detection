# !pip install webdriver_manager




import sys

import joblib
import numpy as np
import pandas as pd
import requests
import tqdm
from flask import Flask, jsonify, request, url_for
from sklearn.feature_extraction.text import TfidfVectorizer

sys.path.append( '../../model/' )
import my_functions as f

vectorizer = joblib.load('../../model/vectorizer.joblib')


app = Flask(__name__)

# Load the fake news detection model
# vectorizer = joblib.load('vectorizer.joblib')

# Define a route for the API    
@app.route('/predict', methods=['POST'])
def predict():
    # Get the input data from the request
    data = request.json
    if not data or 'input' not in data:
        return jsonify({'error': 'Invalid input'})
    tweet = data['input']

    # Preprocess the tweets
    cleaned_tweet = preprocess_tweets(tweet)

    #tweet url
    print(url_to_weight(tweet))

    # Vectorize the preprocessed tweets
    vectorized_tweet = vectorizer.transform(cleaned_tweet.split('\n'))    
    dense = vectorized_tweet.todense()
    feature_names = vectorizer.get_feature_names_out()
    denselist = dense.tolist()  
    tfidf_df = pd.DataFrame(denselist, columns=feature_names)

    url_weights = url_to_weight(tweet)

    # added_to_table=pd.DataFrame({'z_url1': [url_weights[0]], 'z_url2': [url_weights[1]]})
    tfidf_df['url1']=url_weights[0]
    tfidf_df['url2']=url_weights[1]
    
    # table_for_model=tfidf_df.add(added_to_table, fill_value=0)

    #read the model
    with open('../../model/model.joblib', 'rb') as m:
        model = joblib.load(m)
        
    # Make predictions
    predictions = model.predict(tfidf_df)
    print("preiction...............", predictions)
    
    # Create a dictionary with the predictions
    results = {'predictions': predictions.tolist()}

    # Return the results as an HTTP response in JSON format
    response = jsonify(results)
    response.headers['Content-Type'] = 'application/json'
    return response


# Define a helper function to preprocess the tweets
def preprocess_tweets(tweet):
    cleaned_tweet = tweet
    cleaned_tweet = f.remove_emoji(cleaned_tweet)
    cleaned_tweet = f.remove_symbols(cleaned_tweet)
    cleaned_tweet = f.remove_space(cleaned_tweet)
    cleaned_tweet = f.extract_mention(cleaned_tweet)
    cleaned_tweet = f.remove_urls(cleaned_tweet)
    return cleaned_tweet

#url check 
def url_to_weight(tweet):
    url_weights_list=[]
    test_url=[]
    url_list=f.find_url(tweet)
    if len(url_list)>=2:
        test_url.append(url_list[0][0])
        test_url.append(url_list[1][0])
        for url in (test_url):
            text=status_of_link(url)
            url_weights_list.append(sim_of_text(text,tweet))
    elif len(url_list)==1:
        url=url_list[0][0]
        text=status_of_link(url)
        url_weights_list.append(sim_of_text(text,tweet))
        url_weights_list.append(0)
    else:
        url_weights_list=[0,0]
    return url_weights_list

def sim_of_text(url,tweet):
    word = "twitter.com"
    if url == "_":
        return 0
    if word in url:
        return 0
    else:
        a=f.sim_values_url_v1(url,tweet)
        return a

def status_of_link(url):
    try:
        response = requests.get(url,timeout=50)
        if response.status_code == 200:
            return response.url
        else:
            return '_'
    except requests.exceptions.RequestException as e:
        return '_'
    
# Run the Flask app
if __name__ == '_main_':
    app.run()