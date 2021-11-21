#include <QApplication>
#include <QMainWindow>
#include <QPushButton>
#include <QIcon>
#include <QString>
#include <QKeyEvent>
#include <string>
#include <cstdlib>

class MainWindow: public QMainWindow {
    Q_OBJECT
    public:
        QWidget *parent;

        MainWindow(QWidget *_parent = nullptr): QMainWindow(_parent), parent(_parent) {};
        ~MainWindow() {};
    protected:
        void keyPressEvent(QKeyEvent *_event) override {
            if(_event->key() == Qt::Key_Q || _event->key() == Qt::Key_Escape) {
                this->close();
            }
        }
};

int command = 0;
void onExit() {
    switch(command) {
        case 1:
            system("sudo shutdown now");
            break;
        case 2:
            system("sudo reboot");
            break;
        case 3:
            system("sleep 0.2 && lock.sh && sudo systemctl hibernate");
            break;
        case 4:
            system("sleep 0.2 && lock.sh && sudo systemctl suspend");
            break;
        case 5:
            system("sleep 0.2 && lock.sh");
            break;
        default:
            break;
    }
}

void setBtnStylesheet(QPushButton *_button, std::string _icon) {
    _button->setStyleSheet(QString::fromStdString(
        "QPushButton {"\
        "    background-color: #202020;"\
        "    border: none;"\
        "    background-image: url("+_icon+");"\
        "    background-repeat: no-repeat;"\
        "    background-position: center;"\
        "}"\
        "QPushButton:hover {"\
        "    background-color: #303030;"\
        "}"
    ));
}

int main(int argc, char *argv[]) {
    QApplication powermenu(argc, argv);
    MainWindow win;
    win.setFixedSize(500, 100);
    win.setWindowTitle("Power Menu");
    win.setWindowFlags(Qt::Window | Qt::FramelessWindowHint);
    win.show();

    std::string user = std::getenv("HOME");
    std::atexit(onExit);

    QPushButton shutdown("", &win);
    shutdown.setFixedSize(100, 100);
    setBtnStylesheet(&shutdown, ":/icon/shutdown");
    QObject::connect(&shutdown, &QPushButton::clicked, [&win]()->void{command = 1; win.close();});
    shutdown.show();

    QPushButton reboot("", &win);
    reboot.setFixedSize(100, 100);
    reboot.move(100, 0);
    setBtnStylesheet(&reboot, ":/icon/reboot");
    QObject::connect(&reboot, &QPushButton::clicked, [&win]()->void{command = 2; win.close();});
    reboot.show();

    QPushButton hibernate("", &win);
    hibernate.setFixedSize(100, 100);
    hibernate.move(200, 0);
    setBtnStylesheet(&hibernate, ":/icon/hibernate");
    QObject::connect(&hibernate, &QPushButton::clicked, [&win]()->void{command = 3; win.close();});
    hibernate.show();

    QPushButton suspend("", &win);
    suspend.setFixedSize(100, 100);
    suspend.move(300, 0);
    setBtnStylesheet(&suspend, ":/icon/sleep");
    QObject::connect(&suspend, &QPushButton::clicked, [&win]()->void{command = 4; win.close();});
    suspend.show();

    QPushButton lock("", &win);
    lock.setFixedSize(100, 100);
    lock.move(400, 0);
    setBtnStylesheet(&lock, ":/icon/lock");
    QObject::connect(&lock, &QPushButton::clicked, [&win]()->void{command = 5; win.close();});
    lock.show();

    shutdown.setFocusPolicy(Qt::NoFocus);
    reboot.setFocusPolicy(Qt::NoFocus);
    hibernate.setFocusPolicy(Qt::NoFocus);
    suspend.setFocusPolicy(Qt::NoFocus);
    lock.setFocusPolicy(Qt::NoFocus);

    return powermenu.exec();
}

#include "main.moc"
