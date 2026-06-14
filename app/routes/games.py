from flask import Blueprint, request, jsonify
from flask_jwt_extended import jwt_required, get_jwt_identity
from app import db
from app.models import Game

games_bp = Blueprint('games', __name__)

@games_bp.route('/games', methods=['GET'])
@jwt_required()
def get_games():
    games = Game.query.all()
    return jsonify([{'id': g.id, 'title': g.title, 'genre': g.genre} for g in games]), 200

@games_bp.route('/games', methods=['POST'])
@jwt_required()
def add_game():
    data = request.get_json()
    if not data.get('title'):
        return jsonify({'error': 'Title required'}), 400
    game = Game(title=data['title'], genre=data.get('genre', ''), user_id=get_jwt_identity())
    db.session.add(game)
    db.session.commit()
    return jsonify({'message': 'Game added'}), 201

@games_bp.route('/games/<int:id>', methods=['DELETE'])
@jwt_required()
def delete_game(id):
    game = Game.query.get_or_404(id)
    db.session.delete(game)
    db.session.commit()
    return jsonify({'message': 'Game deleted'}), 200