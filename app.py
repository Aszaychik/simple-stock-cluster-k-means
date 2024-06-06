from flask import Flask, render_template, url_for, redirect, request, flash
from flask_sqlalchemy import SQLAlchemy
from flask_assets import Bundle, Environment
from flask_login import UserMixin, login_user, LoginManager, login_required, logout_user, current_user
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SubmitField
from wtforms.validators import InputRequired, Length, ValidationError
from flask_bcrypt import Bcrypt
from werkzeug.utils import secure_filename
import os
import csv

app = Flask(__name__)

assets = Environment(app)
css = Bundle("src/main.css", output="dist/main.css")
assets.register("css", css)
css.build()

# Set the database URI configuration
database_uri = os.environ.get('SQLALCHEMY_DATABASE_URI') or 'mysql+pymysql://root:@localhost/toko_karunia'
print(f"Database URI: {database_uri}")  # Debugging print statement

app.config['SQLALCHEMY_DATABASE_URI'] = database_uri
app.config['SECRET_KEY'] = os.environ.get('SECRET_KEY') or 'kayoko_imut'
app.config['UPLOAD_FOLDER'] = 'uploads'
app.config['ALLOWED_EXTENSIONS'] = {'csv'}

# Initialize the database
db = SQLAlchemy(app)
bcrypt = Bcrypt(app)

login_manager = LoginManager()
login_manager.init_app(app)
login_manager.login_view = 'login'


@login_manager.user_loader
def load_user(user_id):
    return User.query.get(int(user_id))


class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(20), nullable=False, unique=True)
    password = db.Column(db.String(80), nullable=False)


class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    nama = db.Column(db.String(255), nullable=False)
    stok_awal = db.Column(db.Integer, nullable=False)
    stok_terjual = db.Column(db.Integer, nullable=False)
    harga = db.Column(db.Float, nullable=False)


class RegisterForm(FlaskForm):
    username = StringField(validators=[InputRequired(), Length(min=4, max=20)], render_kw={"placeholder": "Username"})
    password = PasswordField(validators=[InputRequired(), Length(min=8, max=20)], render_kw={"placeholder": "Password"})
    submit = SubmitField('Register')

    def validate_username(self, username):
        existing_user_username = User.query.filter_by(username=username.data).first()
        if existing_user_username:
            raise ValidationError('That username already exists. Please choose a different one.')


class LoginForm(FlaskForm):
    username = StringField(validators=[InputRequired(), Length(min=4, max=20)], render_kw={"placeholder": "Username"})
    password = PasswordField(validators=[InputRequired(), Length(min=8, max=20)], render_kw={"placeholder": "Password"})
    submit = SubmitField('Login')


def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']


@app.route('/')
@login_required
def home():
    return redirect(url_for('login'))


@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        user = User.query.filter_by(username=form.username.data).first()
        if user and bcrypt.check_password_hash(user.password, form.password.data):
            login_user(user)
            return redirect(url_for('dashboard'))
    return render_template('login.html', form=form)


@app.route('/dashboard', methods=['GET', 'POST'])
@login_required
def dashboard():
    return render_template('dashboard.html')


@app.route('/logout', methods=['GET', 'POST'])
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))


@app.route('/register', methods=['GET', 'POST'])
def register():
    form = RegisterForm()
    if form.validate_on_submit():
        hashed_password = bcrypt.generate_password_hash(form.password.data)
        new_user = User(username=form.username.data, password=hashed_password)
        db.session.add(new_user)
        db.session.commit()
        return redirect(url_for('login'))
    return render_template('register.html', form=form)

products = []

@app.route('/data')
def data_table():
    # Retrieve product data from the database
    products = Product.query.all()
    return render_template('data.html', products=products)


@app.route('/klasterisasi')
def klasterisasi_page():
    products = Product.query.all()
    return render_template('klasterisasi.html', products=products)

@app.route('/upload_csv', methods=['POST'])
@login_required
def upload_csv():
    if 'file' not in request.files:
        flash('No file part')
        return redirect(request.url)
    file = request.files['file']
    if file.filename == '':
        flash('No selected file')
        return redirect(request.url)
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        file.save(file_path)
        # Process the CSV file
        with open(file_path, mode='r') as f:
            csv_reader = csv.DictReader(f)
            for row in csv_reader:
                nama = row['nama'].strip()
                if not nama:
                    continue  # Skip rows with empty 'nama'

                stok_awal = int(row['stok_awal'].strip() or 0)
                stok_terjual = int(row['stok_terjual'].strip() or 0)
                harga = float(row['harga'].strip() or 0.0)

                product = Product.query.filter_by(nama=nama).first()
                if product:
                    product.stok_awal = stok_awal
                    product.stok_terjual = stok_terjual
                    product.harga = harga
                else:
                    new_product = Product(
                        nama=nama,
                        stok_awal=stok_awal,
                        stok_terjual=stok_terjual,
                        harga=harga
                    )
                    db.session.add(new_product)
            db.session.commit()
        flash('File successfully uploaded and data updated')
        return redirect(url_for('klasterisasi_page'))
    else:
        flash('Allowed file types are csv')
        return redirect(request.url)


if __name__ == "__main__":
    if not os.path.exists(app.config['UPLOAD_FOLDER']):
        os.makedirs(app.config['UPLOAD_FOLDER'])
    app.run(debug=True)
