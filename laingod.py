from contextlib import nullcontext
import datetime
from fileinput import filename
from random import sample
from flask import Flask, render_template, session, url_for,request, redirect,flash
from flask_mysqldb import MySQL
from config import config 
from werkzeug.security import generate_password_hash
from models.ModelUser import ModelUser
from models.entities.User import User
from flask_login import LoginManager, login_user, logout_user, current_user
from werkzeug.utils import secure_filename 
import os
from flask_mail  import Mail, Message


laingodApp=Flask(__name__) 
valor = 0

laingodApp.config['MAIL_SERVER'] = 'smtp.gmail.com'
laingodApp.config['MAIL_PORT'] = 587
laingodApp.config['MAIL_USE_TLS'] = True
laingodApp.config['MAIL_USE_SSL'] = False
laingodApp.config['MAIL_USERNAME'] = 'juan.tadeo1690@alumnos.udg.mx'
laingodApp.config['MAIL_PASSWORD'] = 'mayb wmax lfca xqjc'
laingodApp.config['MAIL_DEFAULT_SENDER'] = 'juan.tadeo1690@alumnos.udg.mx'
laingodApp.config['MAIL_ASCII_ATACHMENTS'] = True

db = MySQL(laingodApp)

laingod = LoginManager(laingodApp)

mail = Mail(laingodApp)
perfi = ''
@laingod.user_loader
def loader_user(id):
    return ModelUser.get_by_id(db,id)

@laingodApp.route('/')
def home():
    return render_template('home.html')

@laingodApp.route('/signin',methods=['GET','POST'])
def signin():
    if request.method == 'POST':
        regUsuario = db.connection.cursor()
       
        nombreu = request.form['Nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        file = request.files['imagenuser']
        carpet = 'imguser'
        imgrute =  "img/imguser/" + upload_img(file,carpet) 
        claveCifrada = generate_password_hash(claveu)
        regUsuario.execute("INSERT INTO usuario (Nombreu, correou, claveu) VALUES (%s,%s,%s)", (nombreu,correou, claveCifrada))
        db.connection.commit()
        imguser = db.connection.cursor()
        imguser.execute("SELECT id FROM usuario WHERE correou=%s ",(correou,))
        iduser= imguser.fetchone()
        regUsuario.execute("INSERT INTO gpersonal (idususario, ruta) VALUES (%s,%s)",(iduser, imgrute))
        db.connection.commit()
       
        
        msg = Message(subject='Bienvenido', recipients=[correou])
        msg.html = render_template("user_email.html", nombre = nombreu)
        mail.send(msg)
        return redirect(url_for('home'))

    else:
        return render_template('home.html')

@laingodApp.route('/permitir_sesion', methods=['GET','POST'])
def permitir_sesion():
      
        return redirect(url_for('imageneslist'))
   
@laingodApp.route('/login',methods=['GET','POST'])
def login():
    if request.method == 'POST':
        usuario = User(0,None,request.form['correou'],request.form['claveu'],None)
        usuarioAut = ModelUser.login(db,usuario)
        if usuarioAut is not None:
            login_user(usuarioAut)
            session['id_user'] = usuarioAut.id
            session['correo_user'] = usuarioAut.correou
            if usuarioAut.claveu:
                if usuarioAut.perfilu == 'A':
                    return  render_template('admin.html')
                else:
                     id = usuarioAut.id
                     correo = usuarioAut.correou
                     loadimg = db.connection.cursor()  
                     loadimg.execute("SELECT id, ruta FROM usuario LEFT JOIN gpersonal ON id = idususario WHERE id=%s",(id,))
                     imguser = loadimg.fetchone()
                     loadata = db.connection.cursor()
                     loadata.execute("SELECT Nombreu FROM usuario where id=%s",(id,))
                     nombre = loadata.fetchall()
                     session['img_user'] = imguser
                     print(session)
                
                     return render_template('home2.html',imguser=imguser, correo = correo, nombre = nombre)


            else:
                flash('Contraseña erronea')
                return redirect(request.url)
        else:
            flash('Usuario no localizado')
            return redirect(request.url)
       
        
    else:
        return render_template('home.html')

@laingodApp.route('/logout',methods=['GET','POST'] )
def logout():
    logout_user()
    return redirect(url_for('home'))

@laingodApp.route('/perfilup')
def perfilup():
    return render_template("perfil.html")

@laingodApp.route('/sUsuario',methods=['GET','POST'])
def sUsuario():
    SelUsuario = db.connection.cursor()
    SelUsuario.execute("SELECT * FROM usuario")
    u = SelUsuario.fetchall()
    
    imagenes_por_usuario = {}
    for us in u:
        id_usuario = us[0] 
        SelImagenes = db.connection.cursor()
        SelImagenes.execute("SELECT *, ruta FROM usuario LEFT JOIN gpersonal ON id = idususario WHERE id=%s", (id_usuario,))
        u = SelImagenes.fetchall()
       
        imagenes_por_usuario[id_usuario] = u
    return render_template("usuarios.html", usuarios = imagenes_por_usuario)


@laingodApp.route('/sUsuario/<string:id>/<string:ruta>',methods=['GET','POST'])
def uUsuario(id,ruta):
    if request.method == 'POST':
        nombreu = request.form['Nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        file = request.files['imagenuser']
        carpet = 'imguser'
        imgrute =  "img/imguser/" + upload_img(file,carpet) 
        claveCifrad = generate_password_hash(claveu)
        perfilu = request.form['perfilu']
        upUsuario = db.connection.cursor()
        upUsuario.execute("UPDATE usuario SET Nombreu=%s, correou=%s, claveu =%s, perfilu =%s WHERE id=%s",(nombreu,correou,claveCifrad,perfilu,id))
        db.connection.commit()
        print(ruta)
        print(id)

        if ruta != 1:
         regUsuario = db.connection.cursor()
         regUsuario.execute("UPDATE gpersonal SET ruta=%s WHERE idususario=%s",(imgrute, id))
         db.connection.commit()
         print('g')
         flash('Usuario actualizado')
         return redirect(url_for('sUsuario'))
        
        else:
         regUsuario = db.connection.cursor()
         regUsuario.execute("INSERT INTO gpersonal (idususario, ruta) VALUES (%s,%s)",(id, imgrute))
         db.connection.commit()
         print('h')
        flash('Usuario actualizado')
        return redirect(url_for('sUsuario'))
    else:
        return redirect(request.url)
    
    

@laingodApp.route('/imageneslists/<string:idimg>',methods=['GET','POST'])
def UPimg(idimg):
    if request.method == 'POST':
        tituloimg = request.form['titulo']
        descripcion = request.form['descripciones']
        UPimg = db.connection.cursor()
        UPimg.execute("UPDATE galera SET Tituloimg=%s, Descripcion=%s WHERE IdIMG=%s",(tituloimg,descripcion,idimg))
        db.connection.commit()
        return redirect(url_for('imageneslists'))

@laingodApp.route('/dUsuario/<string:id>', methods=['GET','POST'] )
def dUsuario(id):
    if request.method == 'POST':
        DelUsuario = db.connection.cursor()
        DelUsuario.execute("DELETE FROM usuario WHERE    id=%s",(id,))
        db.connection.commit()
        flash('usuario eliminado bebe')
        return redirect(url_for('sUsuario'))
    else:
        return redirect(request.url)

@laingodApp.route('/iUsuario',methods=['GET','POST'])
def iUsuario():
    if request.method == 'POST':
        regUsuario = db.connection.cursor()
        nombreu = request.form['Nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        claveCifrada = generate_password_hash(claveu)
        perfilu = request.form['perfilu']
        regUsuario.execute("INSERT INTO usuario (Nombreu, correou, claveu,perfilu) VALUES (%s,%s,%s,%s)", (nombreu,correou, claveCifrada,perfilu))
        db.connection.commit()
        return redirect(url_for('sUsuario'))

    else:
        redirect(request.url)


def string_generate():
    string = "kmbnvkjdsvlkcnsdlnfclnsd"
    longitud = 5
    secuencia = string.upper()
    resultado = sample(secuencia, longitud)
    string = "".join(resultado)
    return string

def upload_img(file,carpet):  
        basepath = os.path.dirname(__file__)
        filename =  secure_filename(file.filename)    
        id = string_generate()
        name = filename.split('.')[0] + id + '.' + filename.split('.')[1]
        upload_path = os.path.join(basepath, 'static/img/',carpet, name)
        file.save(upload_path)
        return name

@laingodApp.route('/Uimg/<string:idf>', methods = ['GET','POST'])    
def upload_datos_img(idf):
    if request.method == 'POST':
        Subimg = db.connection.cursor()
        file = request.files['imagen']
        carpet = 'galeria'
        imgrute =  "img/galeria/" + upload_img(file,carpet) 
        titulo = request.form['titulo']
        descripcion = request.form['descripcion']
        fechaactual = datetime.datetime.now()
        fecha_formateada = fechaactual.strftime('%Y-%m-%d %H:%M:%S')
    

        if idf == '1':    
            Subimg.execute("INSERT INTO galera (rutaimg, Tituloimg, Descripcion, FechaS, iduserimg) VALUES (%s,%s,%s,%s,%s)",(imgrute, titulo, descripcion, fecha_formateada, current_user.id))
            db.connection.commit()
            return redirect(url_for('imageneslists'))   
        elif idf== '0': 
            Subimg.execute("INSERT INTO ads (nombre, descripcion, fecha_subida, ruta) VALUES (%s,%s,%s,%s)",(titulo, descripcion, fecha_formateada,imgrute))
            db.connection.commit()
            return redirect(url_for('load_ads'))
        else: 
            Subimg.execute("INSERT INTO galera (rutaimg, Tituloimg, Descripcion, FechaS,iduserimg) VALUES (%s,%s,%s,%s,%s)",(imgrute, titulo, descripcion, fecha_formateada, current_user.id))
            db.connection.commit()
            return redirect(url_for('imageneslist')) 


@laingodApp.route('/listimg')
def imageneslist():
    Selimagenes = db.connection.cursor()
    
    Selimagenes.execute("SELECT * FROM galera")
    img = Selimagenes.fetchall()
    loadimg = db.connection.cursor()  
    loadimg.execute("SELECT ruta FROM ads")
    ad = loadimg.fetchall()
    
    
    imguser = session['img_user']
    print(imguser)

    return render_template("usuario.html", img = img,ads=ad, imguser=imguser)

@laingodApp.route('/listimgs')
def imageneslists():
    Selimagenes = db.connection.cursor()
    Selimagenes.execute("SELECT * FROM galera")
    img = Selimagenes.fetchall()
    
   

  
    return render_template("imagenes.html", img = img)



    


@laingodApp.route('/deleteImg/<string:idimg>', methods=['GET','POST'] )
def deleteImg(idimg):
    if request.method == 'POST':
        DelUsuario = db.connection.cursor()
        DelUsuario.execute("DELETE FROM galera WHERE    IdIMG=%s",(idimg,))
        db.connection.commit()
        flash('publicacion eliminada bebe')
        return redirect(url_for('imageneslists'))
    else:
        return redirect(request.url)
    
@laingodApp.route('/deleteads/<string:idimg>', methods=['GET','POST'] )
def deleteads(idimg):
    if request.method == 'POST':
        DelUsuario = db.connection.cursor()
        DelUsuario.execute("DELETE FROM ads WHERE    ads=%s",(idimg,))
        db.connection.commit()
        flash('publicacion eliminada bebe')
        return redirect(url_for('load_ads'))
    else:
        return redirect(request.url)

@laingodApp.route('/newuser',methods=['GET','POST'])
def newuser():
    if request.method == 'POST':
        regUsuario = db.connection.cursor()
       
        nombreu = request.form['Nombreu']
        correou = request.form['correou']
        claveu = request.form['claveu']
        file = request.files['imagenuser']
        carpet = 'imguser'
        imgrute =  "img/imguser/" + upload_img(file,carpet) 
        claveCifrada = generate_password_hash(claveu)
        regUsuario.execute("INSERT INTO usuario (Nombreu, correou, claveu) VALUES (%s,%s,%s)", (nombreu,correou, claveCifrada))
        db.connection.commit()
        imguser = db.connection.cursor()
        imguser.execute("SELECT id FROM usuario WHERE correou=%s ",(correou,))
        iduser= imguser.fetchone()
        regUsuario.execute("INSERT INTO gpersonal (idususario, ruta) VALUES (%s,%s)",(iduser, imgrute))
        db.connection.commit()
        flash('Usuario agregado')
        return redirect(url_for('sUsuario'))

    else:
        return render_template('home.html')



@laingodApp.route('/load_ads')
def load_ads():
    ads = db.connection.cursor()
    ads.execute("SELECT * FROM ads")
    ad = ads.fetchall()
    db.connection.commit
    return render_template('ads.html',ads = ad)



@laingodApp.route('/editadmin/<string:id>',methods=['POST','GET'])
def editadmin(id):
    if request.method == 'POST':
        nombreu = request.form['Nombreu']
        correou = request.form['correou']
        file = request.files['imagenuser']
        carpet = 'imguser'
        imgrute =  "img/imguser/" + upload_img(file,carpet) 
        print(id)
        upUsuario = db.connection.cursor()
        upUsuario.execute("UPDATE usuario SET Nombreu=%s, correou=%s WHERE id=%s",(nombreu,correou,id))
        db.connection.commit()
        regimg = db.connection.cursor()
        regimg.execute("UPDATE gpersonal SET ruta=%s WHERE idususario=%s",(imgrute, id))
        db.connection.commit()
        print('xd')
        return render_template('admin.html')



@laingodApp.route('/load_perfil', methods=['POST','GET'])
def load_perfil():
    imguser = db.connection.cursor()
    imguser.execute("SELECT ruta  FROM gpersonal WHERE idususario=%s",(session['id_user'],))
    img = imguser.fetchone()
    db.connection.commit()

    imgsaved = db.connection.cursor()
    imgsaved.execute( "SELECT  idimgsave, idimgarchive FROM usuario LEFT JOIN img_saved ON id = idusuario WHERE id=%s",(session['id_user'],))
    imgs = imgsaved.fetchall()
    db.connection.commit()
    imagenes_por_ID = {}
    
    for save in imgs:
      id_IMG = save[0] 
      
     
      imgg = db.connection.cursor()
      imgg.execute("SELECT *  FROM galera WHERE IdIMG=%s",(id_IMG,))
      imgG = imgg.fetchall()
      db.connection.commit()
      imagenes_por_ID[id_IMG,save] = imgG
      print(imagenes_por_ID)
    session['img_user']= img 
   

    if len(imagenes_por_ID)==0 :
          return render_template('perfil2.html', imgu=img)
         
        

    else:
           return render_template('perfil.html', imgu=img,imgs=imagenes_por_ID)
         
     
        

      
@laingodApp.route('/update_img_user',methods=['POST','GET'])
def update_img_user():  
    if  request.method == 'POST':
        file = request.files['file']
        carpet = 'imguser'
        ruta = "img/imguser/"+ upload_img(file,carpet)

        imguser = db.connection.cursor()
        imguser.execute("UPDATE gpersonal SET ruta=%s WHERE idususario=%s",(ruta,session['id_user']))
        db.connection.commit()
        return redirect(url_for('load_perfil'))
    else:
        return(request.url)
    
@laingodApp.route('/edit_name',methods=['POST','GET'])
def edit_name():

        name = request.form['nombreu']
        edit = db.connection.cursor()
        edit.execute("UPDATE usuario SET Nombreu=%s  WHERE id=%s",(name,session['id_user']))
        db.connection.commit()
        return redirect(url_for('load_perfil'))
   
@laingodApp.route('/guardar_imagenes/<string:idmg>')
def guardar_imagenes(idmg):
     
    verificate= db.connection.cursor()
    verificate.execute("SELECT  idimgsave FROM img_saved  WHERE idimgsave=%s AND idusuario=%s",(idmg,session['id_user']))
    img = verificate.fetchone()
    db.connection.commit()


    print(idmg)
    
 

    if img is not None and img[0] != idmg: 
     print('error puto')
     return redirect(url_for('imageneslist'))
    
    else: 
     album = db.connection.cursor()
     album.execute("INSERT INTO img_saved (idimgsave,idusuario) VALUES (%s,%s)",(idmg,session['id_user']))
     db.connection.commit()
    
    return redirect(url_for('imageneslist'))



@laingodApp.route('/delete_imagenes/<string:idmg>',methods=['GET','POST'])
def delete_imagenes(idmg):
    if request.method =='POST':
     album = db.connection.cursor()
     album.execute("DELETE FROM img_saved WHERE idimgarchive=%s",(idmg,))
     db.connection.commit()
    
    return redirect(url_for('load_perfil'))





    

if __name__=='__main__':
    laingodApp.config.from_object(config['development'])
    laingodApp.run(debug=True,port=5500)
    
