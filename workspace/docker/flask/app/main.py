from flask import Flask
app = Flask(__name__)


@app.route("/home")
def hello():
    return "Welcome to Home \n"


if __name__ == "__main__":
    app.run(host='0.0.0.0', port=80)
