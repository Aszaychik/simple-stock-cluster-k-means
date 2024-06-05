import os

class Config:
    SECRET_KEY = os.environ.get('SECRET_KEY') or 'kayoko_imut'
    SQLALCHEMY_DATABASE_URI = os.environ.get('DATABASE_URL') or'mysql+pymysql://root:@localhost/toko_karunia'
    SQLALCHEMY_TRACK_MODIFICATIONS = False