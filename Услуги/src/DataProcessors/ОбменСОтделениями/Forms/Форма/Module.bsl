&НаСервереБезКонтекста
Функция ПредопределенныйУзел(Узел)
	
	Возврат Узел = ПланыОбмена.Отделения.ЭтотУзел();
	 
КонецФункции


&НаКлиенте
Процедура ОтделениеОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	Если ПредопределенныйУзел(ВыбранноеЗначение) Тогда
		Элементы.СоздатьНачальныйОбраз.Доступность = Ложь;
	Иначе 
		Элементы.СоздатьНачальныйОбраз.Доступность = Истина;
	
	КонецЕсли;
	
КонецПроцедуры


&НаКлиенте
Асинх Процедура СоздатьНачальныйОбраз(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога);
	Диалог.Заголовок = "Укажите каталог информации";
	
	Если Ждать Диалог.ВыбратьАсинх() <> Неопределено Тогда
		ЗаписатьИзмененияНаСервере(Отделение, Диалог.ПолноеИмяФайла);
		
		Сообщить("Запись изменений завершена");
	КонецЕсли;
		
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ЗаписатьИзмененияНаСервере(Узел, ИмяФайла)

	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.ОткрытьФайл(ИмяФайла);
	
	ЗаписьСообщения = ПланыОбмена.СоздатьЗаписьСообщения();
	ЗаписьСообщения.НачатьЗапись(ЗаписьXML, Узел);
	
	ПланыОбмена.ЗаписатьИзменения(ЗаписьСообщения);

	ЗаписьСообщения.ЗакончитьЗапись();
	ЗаписьXML.Закрыть();

КонецПроцедуры


&НаКлиенте
Асинх Процедура ПрочитатьИзменения(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Заголовок = "Укажите файл обмена";
	Если Ждать Диалог.ВыбратьАсинх() <> Неопределено Тогда
		ПрочитатьИзмененияНаСервере(Диалог.ПолноеИмяФайла);
		
		Сообщить("Чтение изменений завершено.");
		
	КонецЕсли;
	
КонецПроцедуры



&НаСервереБезКонтекста
Процедура ПрочитатьИзмененияНаСервере(ИмяФайла)

	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.ОткрытьФайл(ИмяФайла);
	
	ЧтениеСообщения = ПланыОбмена.СоздатьЧтениеСообщения();
	ЧтениеСообщения.НачатьЧтение(ЧтениеXML);
	
	ПланыОбмена.ПрочитатьИзменения(ЧтениеСообщения);
	
	ЧтениеСообщения.ЗакончитьЧтение();
	ЧтениеXML.Закрыть();

КонецПроцедуры



