from bs4 import BeautifulSoup
import sys
import re
import json
import os
import rich
from html import unescape

image_formats = [
    'png', 'apng', 'jpg', 'jpeg', 'avif', 'gif', 'jfif', 'pjpeg', 'pjp', 'webp', 'svg'
]

class SimpleCircles:
    def setSoup(self, soup):
        self.soup = soup

    def writeFile(self):
        replace = self.soup.prettify()
        replace = re.sub('[ \n]+<span>[ \n]+', '<span> ', replace)
        replace = re.sub('[ \n]+</span>[ \n]+', ' </span>', replace)
        try:
            with open(sys.argv[2] + '/index.html', 'w') as file:
                file.write(str(replace))
        except Exception as e:
            rich.print(f'[red]Error[/] > Could not write to file ([bright_blue]{sys.argv[2]}/index.html[/]): [red]{e}[/]')
            exit()

    # Set
    def setUser(self):
        if len(sys.argv) > 4:
            self.soup.find(id='user').string.replaceWith(f' {sys.argv[4]} ')
            self.writeFile()
        else:
            rich.print('[red]Error[/] > Not enough arguments...')
            exit()

    def setTheme(self):
        if len(sys.argv) > 4:
            try:
                with open(f'themes/{sys.argv[2]}/{sys.argv[4]}.json') as file:
                    theme = json.loads(file.read())
            except Exception as e:
                rich.print(f'[red]Error > Could not open file "[light_blue]themes/{sys.argv[2]}/{sys.argv[4]}.json[/]": [red]{e}[/]')
                exit()
            try:
                file = open(f'{sys.argv[2]}/style.css', 'r+')
            except Exception as e:
                rich.print(f'[red]Error[/] > Could not open file "[bright_blue]{sys.argv[2]}/style.css[/]": [red]{e}[/]')
                exit()
            stylesheet = file.read()
            stylesheet = re.sub(r'(.*?body.*?background-color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["background"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?#message.*?text-shadow\s*?:\s*?)(.*?)(;)', rf'\1 0px 0px 10px {theme["text_shadow"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?#message.*?color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["welcome_message"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?#user.*?color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["user"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?#date.*?color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["date"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?\.widget-background.*?box-shadow\s*?:\s*?)(.*?)(;)', rf'\1 5px 5px 5px {theme["icon_shadow"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?\.widget-background.*?background-color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["circle_background"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?\.widget\s*?svg.*?color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["icon"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?\.widget\s*?svg.*?stroke\s*?:\s*?)(.*?)(;)', rf'\1 {theme["icon"]}\3', stylesheet, flags=re.DOTALL)
            stylesheet = re.sub(r'(.*?\.widget-name.*?color\s*?:\s*?)(.*?)(;)', rf'\1 {theme["widget_name"]}\3', stylesheet, flags=re.DOTALL)
            try:
                file.seek(0)
                file.write(stylesheet)
                file.truncate()
                file.close()
            except Exception as e:
                rich.print(f'[red]Error[/] > Could not write to file "[light_blue]{sys.argv[2]}/style.css[/]": [red]{e}[/]')
                exit()
        else:
            rich.print('[red]Error[/] > Not enough arguments...')
            exit()

    def showSeconds(self):
        if len(sys.argv) > 4:
            if sys.argv[4] == 'true':
                del self.soup.find(id='seconds')['style']
                self.writeFile()
            elif sys.argv[4] == 'false':
                self.soup.find(id='seconds')['style'] = 'display: none;'
                self.writeFile()
            else:
                rich.print(f'[red]Error > Invalid argument "[light_blue]{sys.argv[4]}[/]"; must be true/false...')
                exit()
        else:
            rich.print('[red]Error[/] > Not enough arguments...')
            exit()

    def showNames(self):
        if len(sys.argv) > 4:
            if sys.argv[4] == 'true':
                wg = self.soup.findAll(class_='widget')
                for i in wg:
                    i['class'] = 'widget-t'
                wg_bg = self.soup.findAll(class_='widget-background')
                for i in wg_bg:
                    i['class'] = 'widget-background-t'
                wg_nm = self.soup.findAll(class_='widget-name')
                for i in wg_nm:
                    del i['style']
                self.writeFile()
            elif sys.argv[4] == 'false':
                wg_t = self.soup.findAll(class_='widget-t')
                for i in wg_t:
                    i['class'] = 'widget'
                wg_bg_t = self.soup.findAll(class_='widget-background-t')
                for i in wg_bg_t:
                    i['class'] = 'widget-background'
                wg_nm_t = self.soup.findAll(class_='widget-name')
                for i in wg_nm_t:
                    i['style'] = 'display: none;'
                self.writeFile()
            else:
                rich.print(f'[red]Error[/] > Invalid argument "[red]{sys.argv[4]}[/]"; must be true/false...')
                exit()
        else:
            rich.print('[red]Error[/] > Not enough arguments...')
            exit()

    # List
    def listWidgets(self):
        names = []
        for div in self.soup.findAll(class_='widget-name'):
            names.append(div.string)
        for name in names:
            name = re.sub(r"\s{2,}", "", name)
            rich.print(f'"[blue]{name}[/]"   ', end='')
        print()

    def listThemes(self):
        files = []
        for (_, _, f) in os.walk(f'themes/{sys.argv[2]}'):
            files.extend(f)
            break
        for theme in files:
            token = theme.find('.')
            rich.print(f'[blue]{theme[:token]}[/]    ', end='')
        print()

    # Add
    def addWidget(self):
        if self.soup.find(class_='widget'):
            active_class = ''
        else:
            active_class = '-t'

        if len(sys.argv) >= 6:
            widget = self.soup.new_tag('div', **{'class': f'widget{active_class}'}, onclick=f"window.location.href='{sys.argv[5]}'")
            widget_bg = self.soup.new_tag('div', **{'class': f'widget-background{active_class}'})
            if self.soup.find(class_='widget-name', style='display: none;'):
                widget_name = self.soup.new_tag('p', **{'class': 'widget-name'}, style='display: none;')
            else:
                widget_name = self.soup.new_tag('p', **{'class': 'widget-name'})
            widget_name.string = sys.argv[4]
            if len(sys.argv) == 7:
                if os.path.isfile(sys.argv[6]):
                    if re.search(r'.*?\.svg$', sys.argv[6]):
                        image = ''
                        try:
                            image = open(sys.argv[6], 'r')
                        except Exception as e:
                            rich.print(f'[red]Error[/] > Could not open image "[bright_blue]{sys.argv[6]}[/]": [red]{e}[/]')
                            exit()
                        widget_bg.append(BeautifulSoup(image.read(), 'xml'))
                        image.close()
                    else:
                        valid = False
                        for extension in image_formats:
                            if re.search(rf'.*?\.{extension}', sys.argv[6]):
                                widget_bg.append(self.soup.new_tag('img', src=sys.argv[6]))
                                valid = True
                                break
                        if not valid:
                            rich.print('[red]Error[/] > File format not supported')
                            exit()
                else:
                    rich.print(f'[red]Error > File "[bright_blue]{sys.argv[6]}[/]" not found')
            widget.append(widget_bg)
            widget.append(widget_name)
            widget_container = self.soup.find(id='widget-container')
            widget_container.append(widget)
            self.writeFile()
        else:
            rich.print('[red]Error[/] > Not enough arguments...')
            exit()
    # Remove
    def removeWidget(self):
        widget_class = ''
        if self.soup.find(class_='widget'):
            widget_class = 'widget'
        else:
            widget_class = 'widget-t'
        for widget in self.soup.findAll(class_=widget_class):
            if re.search(rf'^\s*{sys.argv[4]}\s*$', widget.find(class_='widget-name').string.strip('\n')):
                widget.decompose()
        self.writeFile()

    attr_set = {
        'user': 'setUser',
        'theme': 'setTheme',
        'show-seconds': 'showSeconds',
        'show-names': 'showNames'
    }
    attr_list = {
        'widgets': 'listWidgets',
        'themes': 'listThemes'
    }
    attr_add = {
        'widget': 'addWidget'
    }
    attr_remove = {
        'widget': 'removeWidget'
    }

def setAttr(obj):
    if len(sys.argv) > 3:
        if sys.argv[3] in obj.attr_set:
            getattr(obj, obj.attr_set[sys.argv[3]])()
        else:
            rich.print(f'[red]Error[/] > Invalid argument "[light_blue]{sys.argv[3]}[/]"...')
            exit()
    else:
        rich.print('[red]Error[/] > Not enough arguments...')
        exit()

def listItems(obj):
    if len(sys.argv) > 3:
        if sys.argv[3] in obj.attr_list:
            getattr(obj, obj.attr_list[sys.argv[3]])()
        else:
            rich.print(f'[red]Error[/] > Invalid argument "[light_blue]{sys.argv[3]}[/]...')
            exit()
    else:
        rich.print('[red]Error[/] > Not enough arguments...')
        exit()

def addItem(obj):
    if len(sys.argv) > 3:
        if sys.argv[3] in obj.attr_add:
            getattr(obj, obj.attr_add[sys.argv[3]])()
        else:
            rich.print(f'[red]Error[/] > Invalid argument "[light_blue]{sys.argv[3]}[/]...')
            exit()
    else:
        rich.print('[red]Error[/] > Not enough arguments...')
        exit()

def removeItem(obj):
    if len(sys.argv) > 3:
        if sys.argv[3] in obj.attr_add:
            getattr(obj, obj.attr_remove[sys.argv[3]])()
        else:
            rich.print(f'[red]Error[/] > Invalid argument "[light_blue]{sys.argv[3]}[/]...')
            exit()
    else:
        rich.print('[red]Error[/] > Not enough arguments...')
        exit()

arguments_1 = {
    'set': setAttr,
    'list': listItems,
    'add': addItem,
    'remove': removeItem
}

simcir = SimpleCircles()

arguments_2 = {
    'simple-circles': simcir,
}

def setPage(pg):
    try:
        page = open(pg + '/index.html')
    except Exception as e:
        rich.print(f'[red]Error[/] > Could not open file "[light_blue]{pg}/index.html[/]": [red]{e}[/]')
        exit()
    soup = BeautifulSoup(page, 'lxml')
    simcir.setSoup(soup)

if __name__ == '__main__':
    if len(sys.argv) > 2:
        if sys.argv[1] in arguments_1:
            if sys.argv[2] in arguments_2:
                setPage(sys.argv[2])
                arguments_1[sys.argv[1]](arguments_2[sys.argv[2]])
            else:
                rich.print(f'[red]Error[/] > "[light_blue]{sys.argv[2]}[/]" is not a recognized page...')
        else:
            rich.print(f'[red]Error[/] > Invalid command "[light_blue]{sys.argv[1]}[/]"...')
    else:
        rich.print('[red]Error[/] > Not enough arguments...')
