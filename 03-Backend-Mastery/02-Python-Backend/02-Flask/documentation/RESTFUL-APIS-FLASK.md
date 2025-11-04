# RESTful APIs with Flask

## 📚 Overview

Building RESTful APIs with Flask requires proper structure and conventions.

## 🎯 Flask-RESTful

```python
from flask_restful import Resource, Api

api = Api(app)

class UserList(Resource):
    def get(self):
        return {'users': []}
    
    def post(self):
        data = request.get_json()
        # Create user
        return {'id': 1, 'name': data['name']}, 201

class User(Resource):
    def get(self, user_id):
        return {'id': user_id, 'name': 'John'}
    
    def put(self, user_id):
        data = request.get_json()
        # Update user
        return {'id': user_id, 'name': data['name']}
    
    def delete(self, user_id):
        # Delete user
        return '', 204

api.add_resource(UserList, '/users')
api.add_resource(User, '/users/<int:user_id>')
```

## 📝 Request Validation

```python
from marshmallow import Schema, fields

class UserSchema(Schema):
    name = fields.Str(required=True)
    email = fields.Email(required=True)

schema = UserSchema()

@app.route('/users', methods=['POST'])
def create_user():
    errors = schema.validate(request.json)
    if errors:
        return jsonify(errors), 400
    
    data = schema.load(request.json)
    # Create user
    return jsonify(data), 201
```

---

**Next**: Learn about [Blueprints Architecture](./BLUEPRINTS-ARCHITECTURE.md)

