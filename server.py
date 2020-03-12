from flask import Flask
app = Flask(__name__)
@app.route('/')
def index():
    return {"data":"100"}

@app.route('/login',methods=['POST'])
def login():
    return {"data":"200"}

if __name__ == '__main__':
    app.debug = True
    app.run()
