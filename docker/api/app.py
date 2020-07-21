from flask import Flask, jsonify, request
import word_extracter

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

@app.route('/', methods=['POST'])
def index():
    documents = request.json['documents']

    important_words = word_extracter.extract_important_words(documents, number_of_extract=3)

    return jsonify({
        "important_words": important_words
    })

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')