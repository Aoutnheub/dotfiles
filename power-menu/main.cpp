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
        MainWindow(QWidget *parent = nullptr): QMainWindow(parent) {};
        ~MainWindow() {};
    protected:
        void keyPressEvent(QKeyEvent *event) override {
            if(event->key() == Qt::Key_Q) {
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
            system("sleep 0.1 && lock.sh && sudo systemctl hibernate");
            break;
        case 4:
            system("sleep 0.1 && lock.sh && sudo systemctl suspend");
            break;
        case 5:
            system("sleep 0.2 && lock.sh");
            break;
        default:
            break;
    }
}

int main(int argc, char *argv[]) {
    QApplication powermenu(argc, argv);
    MainWindow win;
    win.setFixedSize(500, 100);
    win.setWindowTitle("Power Menu");
    win.setWindowFlags(Qt::Window | Qt::FramelessWindowHint);
    win.show();

    std::string user = std::getenv("USER");
    std::atexit(onExit);

    QPushButton shutdown("", &win);
    shutdown.setFixedSize(100, 100);
    shutdown.setStyleSheet(QString::fromStdString("QPushButton {background-color: #202020; border: none; background-image: url(\"/home/"+user+"/Pictures/icons/shutdown.png\"); background-repeat: no-repeat; background-position: center;} QPushButton:hover {background-color: #303030}"));
    QObject::connect(&shutdown, &QPushButton::clicked, [&win]()->void{command = 1; win.close();});
    shutdown.show();

    QPushButton reboot("", &win);
    reboot.setFixedSize(100, 100);
    reboot.move(100, 0);
    reboot.setStyleSheet(QString::fromStdString("QPushButton {background-color: #202020; border: none; background-image: url(\"/home/"+user+"/Pictures/icons/reboot.png\"); background-repeat: no-repeat; background-position: center;} QPushButton:hover {background-color: #303030}"));
    QObject::connect(&reboot, &QPushButton::clicked, [&win]()->void{command = 2; win.close();});
    reboot.show();

    QPushButton hibernate("", &win);
    hibernate.setFixedSize(100, 100);
    hibernate.move(200, 0);
    hibernate.setStyleSheet(QString::fromStdString("QPushButton {background-color: #202020; border: none; background-image: url(\"/home/"+user+"/Pictures/icons/hibernate.png\"); background-repeat: no-repeat; background-position: center;} QPushButton:hover {background-color: #303030}"));
    QObject::connect(&hibernate, &QPushButton::clicked, [&win]()->void{command = 3; win.close();});
    hibernate.show();

    QPushButton suspend("", &win);
    suspend.setFixedSize(100, 100);
    suspend.move(300, 0);
    suspend.setStyleSheet(QString::fromStdString("QPushButton {background-color: #202020; border: none; background-image: url(\"/home/"+user+"/Pictures/icons/suspend.png\"); background-repeat: no-repeat; background-position: center;} QPushButton:hover {background-color: #303030}"));
    QObject::connect(&suspend, &QPushButton::clicked, [&win]()->void{command = 4; win.close();});
    suspend.show();

    QPushButton lock("", &win);
    lock.setFixedSize(100, 100);
    lock.move(400, 0);
    lock.setStyleSheet(QString::fromStdString("QPushButton {background-color: #202020; border: none; background-image: url(\"/home/"+user+"/Pictures/icons/lock.png\"); background-repeat: no-repeat; background-position: center;} QPushButton:hover {background-color: #303030}"));
    QObject::connect(&lock, &QPushButton::clicked, [&win]()->void{command = 5; win.close();});
    lock.show();

    return powermenu.exec();
}

#include "main.moc"
