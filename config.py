class Config:
    SECRET_KEY='SDPCFMDJSBVDFVNKJDSCÑ,DMFDZKLJCVMASKXCWJDFD,MCKLDZVFHI DSVNDSNJVUIBDVMK NDLJIBVHFDASVKJBDZ.KCJVÑASBFDAS-ÑLVGOÑJDASB'

class DevelopmentConfig(Config):
    DEBUG           = True
    MYSQL_HOST      ='localhost'
    MYSQL_USER      ='root'
    MYSQL_PASSWORD  ='root'
    MYSQL_DB        ='laingod'

config = { 
    'development': DevelopmentConfig
 }

MAIL_SERVER = 'smtp.gmail.com'
MAIL_PORT = 465
MAIL_USE_TLS = True
MAIL_USE_SSL = False
MAIL_USERNAME = 'tadeofrancisco36@gmail.com'
MAIL_PASSWORD = 'ssnibgrtxwhzhcyj'
MAIL_DEFAULT_SENDER = 'tadeofrancisco36@gmail.com'
MAIL_ASCII_ATACHMENTS = True