from ..base import base
from flask import render_template
from flask_login import login_user, logout_user, login_required, \
    current_user
from flask import g, jsonify
from ..models import Resource, Organization, ResourceType

@base.route('/getRouters')
@login_required
def getRouters():
    resources = Resource.query.join(ResourceType, Resource.type).filter(Resource.SYRESOURCE_ID == None).all()
    
    return jsonify({'msg': 'operation success', 'code': 200, "data": [res.to_router_json() for res in resources]})