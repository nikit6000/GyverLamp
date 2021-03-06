# GyverLamp - SSDP
Модификация оригинальной прошивки для корректной работы с iOS приложением [GyLamp](https://apps.apple.com/ru/app/gylamp/id1474547003) 

## Компиляция

Вы можете скомпилировать прошивку двумя способами:
- [В среде Arduino](#Компиляция-в-среде-Arduino)
- [Автоматически](#Автоматическая-компиляция)

### Компиляция в среде Arduino

Для начала необходимо установить Arduino IDE и ядро ESP8266.

- Скачайте и установите Arduino IDE. Новую версию вы всегда сможете найти на сайте [Arduino](https://www.arduino.cc/en/main/software)
- Запустите Arduino и откройте окно настроек
- Добавьте ```https://arduino.esp8266.com/stable/package_esp8266com_index.json``` в поле *Дополнительные ссылки для Менеджера плат*. Вы можете использовать несколько ссылок, разделяя их запятыми
- Откройте *Менеджер плат* в меню "Инструменты > Плата > Менеджер плат ..." и в поисковой строке введите *esp8266*. Установите найденную платформу.
- Скачайте или склонируйте этот репозиторий
- Скопируйте библиотеки из папки *libraries* в папку пользовательских библиотек Arduino.

#### Windows
```
C:\Users\<имя_пользователя>\Documents\Arduino\libraries\
```

#### macOS
```
~/Documents/Arduino/libraries/
```

После установки ядра и библиотек опкройте файл ```firmware/GyverLamp_v1.5.5/GyverLamp_v1_5_5.ino```. В меню *Инструменты* выберите вашу плату и настройте ее параметры следующим образом:

```
Upload speed: "115200"
CPU Frequency: "80 MHz"
Flash size: 4MB (FS 1MB)
Debug port: "Disabled"
Debug level: "Ничего"
lwIP variant: "v2 Higher Bandwidth"
VTables: "flash"
Erase flash: "All Flash Contents"
SSL support: "All SSL ciphers"
```

- нажмите на кнопку "Загрузка"

### Автоматическая компиляция

Для автоматической компиляции необходимо установить Arduino IDE и скачать приложение arduino-cli.

- Скачайте или склонируйте этот репозиторий
- Скачайте и установите Arduino IDE. Новую версию вы всегда сможете найти на сайте [Arduino](https://www.arduino.cc/en/main/software)
- Скачайте [arduino-cli](https://github.com/arduino/arduino-cli/releases) и распакуйте его в корень репозитория так, чтобы *arduino-cli* лежала в одной папке с папкой *firmware*

#### Windows
```
Если у вас NodeMCU v2 запустите LOLIN(WEMOS)_D1_R2_mini_flash_win.bat
Если у вас LOLIN(WEMOS) D1 R2 запустите NodeMCU_v2_flash_win.bat
```

- Введите имя порта
- Ждите окончания прошивки

## Соединение с приложением

После успешной прошивки ESP8266 перезагрузится в режиме точки доступа. Подключитесь к ней и настройте подключение к Wi-Fi. После подключения лампы к локальной сети приложение сможет автоматически находить ее.

## Модификация

В данной версии прошивки можно поменять текст отображаемый в приложении.
- название лампы
- название эффектов





