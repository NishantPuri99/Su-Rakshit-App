from virus_total_apis import PublicApi as VirusTotalPublicApi

API_KEY = '1e6c867056955775c9694af6c51f366fe5121c43e677a47e9b78bd24d8f9a102'

from flask import Flask, request, jsonify

vt = VirusTotalPublicApi(API_KEY)
# urlT = input()

# R = vt.get_url_report(urlT)

app = Flask (__name__)    
@app.route('/')
def homePage():
    return "Add URL to check for at the end in the task bar, <p> for example, <i>localhost/www.google.com</i> </p> "
@app.route('/<name>',methods=['GET','POST'])
def user(name):
    d = {}
    d['Query'] = name
    R = vt.get_url_report(d['Query'])
    number_of_sites = 0
    malicious_number = 0
    clean_number = 0
    for i in R["results"]["scans"]:
        number_of_sites += 1
        if(R["results"]["scans"][i]["detected"]):
            malicious_number +=1
        else:
            clean_number +=1
        # print(R["results"]["scans"][i]["detected"])
        # print(R["results"]["scans"][i]["result"])
        # print(number_of_sites)
        # print(malicious_number)
        # print(clean_number)
    s = f"Total Sites = {number_of_sites}, out of which  {malicious_number} called it unsafe and {clean_number} called it safe"
    d['Query'] = s
    return jsonify(d)
#    print(R["results"]["scans"])
    #return jsonify(R["results"]["scans"])

#    return jsonify(d)
