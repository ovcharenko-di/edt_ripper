#Использовать asserts
#Использовать logos
#Использовать tempfiles
#Использовать fs
#Использовать "../src"

Перем юТест;
Перем Лог;
Перем МенеджерВременныхФайлов;

// Основная точка входа
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	ПередЗапускомТестов();
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;

	ВсеТесты.Добавить("Тест_ОпределениеЕДТ");
	ВсеТесты.Добавить("Тест_ОпределениеКонфигуратора");
	ВсеТесты.Добавить("Тест_ОпределениеОбработки");
	
	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТестов()
	
	Попытка
		ВремТестер = Новый Тестер;
		Лог = Логирование.ПолучитьЛог(ВремТестер.ИмяЛога());
	Исключение
		Лог = Логирование.ПолучитьЛог("Test");
	КонецПопытки;
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
	ПараметрыПриложения.УстановитьРежимОтладки(Истина);
	МенеджерВременныхФайлов = Новый МенеджерВременныхФайлов;
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
	МенеджерВременныхФайлов.Удалить();
	МенеджерВременныхФайлов = Неопределено;
	
КонецПроцедуры

Процедура Тест_ОпределениеЕДТ() Экспорт
	
	ПутьРепо = СоздатьКаталоги(ПолучитьТестовыйНаборДляЕДТ());

	Проект = Новый Проект(ПутьРепо + "/projectName");

	Ожидаем.Что(СтрЗаканчиваетсяНа(Проект.ПутьИсходников(),"src")).ЭтоИстина();
	Ожидаем.Что(Проект.ЭтоЕДТ()).Равно(Истина);
	Ожидаем.Что(Проект.Имя()).Равно("projectName");

КонецПроцедуры

Процедура Тест_ОпределениеКонфигуратора() Экспорт

	ПутьРепо = СоздатьКаталоги(ПолучитьТестовыйНаборДляКонфигуратора());

	Проект = Новый Проект(ПутьРепо + "/src/cf");

	Ожидаем.Что(СтрЗаканчиваетсяНа(Проект.ПутьИсходников(),"cf")).ЭтоИстина();
	Ожидаем.Что(Проект.ЭтоКонфигуратор()).Равно(Истина);
	Ожидаем.Что(Проект.Имя()).Равно("cf");

	Проект = Новый Проект(ПутьРепо + "/src/cfe");
	Ожидаем.Что(СтрЗаканчиваетсяНа(Проект.ПутьИсходников(),"cfe")).ЭтоИстина();
	Ожидаем.Что(Проект.ЭтоКонфигуратор()).Равно(Истина);
	Ожидаем.Что(Проект.Имя()).Равно("cfe");

КонецПроцедуры


Процедура Тест_ОпределениеОбработки() Экспорт

	ПутьРепо = СоздатьКаталоги(ПолучитьТестовыйНаборДляКонфигуратора());

	Проект = Новый Проект(ПутьРепо + "/src/epf/МояОбработка");

	Ожидаем.Что(СтрЗаканчиваетсяНа(Проект.ПутьИсходников(),"МояОбработка")).ЭтоИстина();
	Ожидаем.Что(Проект.ЭтоКонфигуратор()).Равно(Истина);
	Ожидаем.Что(Проект.Имя()).Равно("МояОбработка");

КонецПроцедуры

Функция ПолучитьТестовыйНаборДляЕДТ()
	
	МассивКаталогов = Новый Массив;

	МассивКаталогов.Добавить("D;projectName");
	МассивКаталогов.Добавить("D;projectName/src");
	МассивКаталогов.Добавить("D;projectName/DT-INF");
	МассивКаталогов.Добавить("F;projectName/.project");

	Возврат МассивКаталогов;	

КонецФункции

Функция ПолучитьТестовыйНаборДляКонфигуратора()
	
	МассивКаталогов = Новый Массив;

	МассивКаталогов.Добавить("D;src");
	МассивКаталогов.Добавить("D;src/cf");
	МассивКаталогов.Добавить("F;src/cf/Configuration.xml");
	МассивКаталогов.Добавить("D;src/cfe");
	МассивКаталогов.Добавить("F;src/cfe/Configuration.xml");
	МассивКаталогов.Добавить("D;src/epf/МояОбработка");
	МассивКаталогов.Добавить("F;src/epf/МояОбработка/МояОбработка.xml");

	Возврат МассивКаталогов;	

КонецФункции


Функция СоздатьКаталоги(Массив)

	БазовыйКаталог = МенеджерВременныхФайлов.СоздатьКаталог();
	Для Каждого Элемент Из Массив Цикл

		ТипИмя = СтрРазделить(Элемент,";");
		СозданныйЭлемент = "";
		Если ТипИмя[0] = "D" Тогда
			СозданныйЭлемент = ОбъединитьПути(БазовыйКаталог, ТипИмя[1]);
			ФС.ОбеспечитьКаталог(СозданныйЭлемент);
		ИначеЕсли ТипИмя[0] = "F" Тогда
			СозданныйЭлемент = ОбъединитьПути(БазовыйКаталог, ТипИмя[1]);
			ЗаписьТекста = Новый ЗаписьТекста(СозданныйЭлемент, "utf-8");
			ЗаписьТекста.Закрыть();
		Иначе

		КонецЕсли;

		Лог.Отладка(СозданныйЭлемент);
	КонецЦикла;

	Возврат БазовыйКаталог;

КонецФункции

Функция ПолучитьМассивКаталоговКонфигуратор()
	МассивКаталогов = Новый Массив;
	Возврат МассивКаталогов;
КонецФункции

