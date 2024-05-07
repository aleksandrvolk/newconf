﻿Функция InfoRequestJSON(ПараметрыОперации, ДопПараметрыЗапроса)
	
	// {
	//  programName: String,
	//  versionNumber: String,
	//  platformVersion: String,
	//  programNewName: String,
	//  redactionNumber: String,
	//  updateType: NewConfigurationAndOrPlatform / NewProgramOrRedaction / NewPlatform,
	//  additionalParameters: [
	//    {
	//      key: String,
	//      value: String
	//    }
	//  ]
	// }
	
	ЗаписьДанныхСообщения = Новый ЗаписьJSON;
	ЗаписьДанныхСообщения.УстановитьСтроку();
	ЗаписьДанныхСообщения.ЗаписатьНачалоОбъекта();
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("programName");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(ПараметрыОперации.ИмяТекущейПрограммы);
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("versionNumber");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(ПараметрыОперации.ВерсияТекущейПрограммы);
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("platformVersion");
	ЗаписьДанныхСообщения.ЗаписатьЗначение("8.3.24.1106");
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("programNewName");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(ПараметрыОперации.ИмяНовойПрограммы);
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("redactionNumber");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(ПараметрыОперации.НомерРедакцииНовойПрограммы);
	
	Если ПараметрыОперации.СценарийОбновления = "РабочееОбновление" Тогда
		ИмяСценарияВСервисе = "NewConfigurationAndOrPlatform";
	ИначеЕсли ПараметрыОперации.СценарийОбновления = "ПереходНаДругуюПрограммуИлиРедакцию" Тогда
		ИмяСценарияВСервисе = "NewProgramOrRedaction";
	Иначе
		ИмяСценарияВСервисе = "NewPlatform";
	КонецЕсли;
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("updateType");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(ИмяСценарияВСервисе);
	
	ЗаписатьДополнительныеПараметрыЗапроса(ДопПараметрыЗапроса, ЗаписьДанныхСообщения);
	
	ЗаписьДанныхСообщения.ЗаписатьКонецОбъекта();
	
	Возврат ЗаписьДанныхСообщения.Закрыть();
	
КонецФункции

Процедура ЗаписатьДополнительныеПараметрыЗапроса(ДопПараметрыЗапроса, ЗаписьДанныхСообщения)
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("additionalParameters");
	ЗаписьДанныхСообщения.ЗаписатьНачалоМассива();
	Для каждого КлючЗначение Из ДопПараметрыЗапроса Цикл
		ЗаписьДанныхСообщения.ЗаписатьНачалоОбъекта();
		ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("key");
		ЗаписьДанныхСообщения.ЗаписатьЗначение(КлючЗначение.Ключ);
		ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("value");
		ЗаписьДанныхСообщения.ЗаписатьЗначение(Строка(КлючЗначение.Значение));
		ЗаписьДанныхСообщения.ЗаписатьКонецОбъекта();
	КонецЦикла;
	ЗаписьДанныхСообщения.ЗаписатьКонецМассива();
	
КонецПроцедуры

&НаСервере
Функция ПолучитьВерсииОбновленийНаСервере(ИмяТекущейПрограммы, ВерсияТекущейПрограммы) Экспорт
	
	ПараметрыОперации = Новый Структура();
	ПараметрыОперации.Вставить("ИмяТекущейПрограммы", 			ИмяТекущейПрограммы);
	ПараметрыОперации.Вставить("ВерсияТекущейПрограммы", 		ВерсияТекущейПрограммы);
	ПараметрыОперации.Вставить("ИмяНовойПрограммы", 			"");
	ПараметрыОперации.Вставить("НомерРедакцииНовойПрограммы", 	"");
	ПараметрыОперации.Вставить("СценарийОбновления", 			"РабочееОбновление"); 
	
	ДополнительныеПараметрыЗапроса = Новый Соответствие();
	ДополнительныеПараметрыЗапроса.Вставить("platform64Supported", 	"true"); 
	ДополнительныеПараметрыЗапроса.Вставить("DomainZone", 			"ru");
	ДополнительныеПараметрыЗапроса.Вставить("IBUserName", 			"Александр");
	ДополнительныеПараметрыЗапроса.Вставить("IBIsSeparated", 		"false");
	ДополнительныеПараметрыЗапроса.Вставить("countryId", 			"");
	ДополнительныеПараметрыЗапроса.Вставить("ConfigMainLanguage", 	"ru");
	ДополнительныеПараметрыЗапроса.Вставить("ConfigLanguage", 		"ru");
	ДополнительныеПараметрыЗапроса.Вставить("IBID", 				"a80a89fe-4046-492c-986e-abb2876c7040");
	ДополнительныеПараметрыЗапроса.Вставить("ConfigVersion", 		ВерсияТекущейПрограммы);
	ДополнительныеПараметрыЗапроса.Вставить("ConfigName", 			"УправлениеНебольшойФирмой");  // Заменить
	ДополнительныеПараметрыЗапроса.Вставить("CurLocalizationCode", 	"ru");
	ДополнительныеПараметрыЗапроса.Вставить("Vendor", 				"Фирма ""1С"" ");
	ДополнительныеПараметрыЗапроса.Вставить("SystemLanguage", 		"ru");
	ДополнительныеПараметрыЗапроса.Вставить("LibraryVersion", 		"2.7.3.28");
	ДополнительныеПараметрыЗапроса.Вставить("PlatformVersion", 		"8.3.24.1106");
	ДополнительныеПараметрыЗапроса.Вставить("ClientOSVersion", 		"Microsoft Windows 10 version 10.0  (Build 19045)");
	ДополнительныеПараметрыЗапроса.Вставить("ClientPlatformType", 	"Windows_x86_64");
	ДополнительныеПараметрыЗапроса.Вставить("ClientTimeOffsetGMT", 	"39600");
	
	ПараметрыЗапросаJSON = InfoRequestJSON(ПараметрыОперации, ДополнительныеПараметрыЗапроса);
	
	Заголовки = Новый Соответствие;
	Заголовки.Вставить("Content-Type", "application/json");
	ПараметрыОтправки = Новый Структура;
	ПараметрыОтправки.Вставить("Метод"                   , "POST");
	ПараметрыОтправки.Вставить("ФорматОтвета"            , 1);
	ПараметрыОтправки.Вставить("Заголовки"               , Заголовки);
	ПараметрыОтправки.Вставить("ДанныеДляОбработки"      , ПараметрыЗапросаJSON);
	ПараметрыОтправки.Вставить("ФорматДанныхДляОбработки", 1);
	ПараметрыОтправки.Вставить("Таймаут"                 , 30);
	
	Конфигурация = Новый Структура();
	Конфигурация.Вставить("Версия"                    , "");
	Конфигурация.Вставить("МинимальнаяВерсияПлатформы", "");
	Конфигурация.Вставить("ФайлыДляЗагрузки"          , Новый Массив);
	Конфигурация.Вставить("РазмерОбновления"          , 0);
	Конфигурация.Вставить("URLНовоеВВерсии"           , "");
	Конфигурация.Вставить("URLПорядокОбновления"      , "");
	Конфигурация.Вставить("ИдентификаторВерсии"       , "");
	Конфигурация.Вставить("ДоступноОбновление"        , Ложь);
	Конфигурация.Вставить("ОкончаниеПоддержки"        , Неопределено);
	
	Платформа = Новый Структура();
	Платформа.Вставить("Версия"                    , 				"");
	Платформа.Вставить("URLОсобенностиПерехода", 					"");
	Платформа.Вставить("URLСтраницыПлатформы"          , Новый Массив);
	Платформа.Вставить("ИдентификаторФайла"          , 0);
	Платформа.Вставить("РазмерОбновления"           , "");
	Платформа.Вставить("РекомендуетсяПереход"      , "");
	 	
	Результат = Новый Структура();
	Результат.Вставить("ИмяОшибки", "");
	Результат.Вставить("Сообщение", "");
	Результат.Вставить("ИнформацияОбОшибке", "");
	Результат.Вставить("ДоступноОбновление", "");
	Результат.Вставить("Сценарий", "");
	Результат.Вставить("Конфигурация", Конфигурация);
	Результат.Вставить("Платформа", Платформа);
	Результат.Вставить("Исправления", "");
	Результат.Вставить("ДополнительныеВерсии", Новый Массив);
	Результат.Вставить("ОкончаниеПоддержкиТекущейВерсии", ""); 	
	
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/json");

	Соединение = Новый HTTPСоединение("update-api.1c.ru",,,,,,Новый ЗащищенноеСоединениеOpenSSL());
	ЗапросОтправки = Новый HTTPЗапрос("/update-platform/programs/update/info"); 
	ЗапросОтправки.Заголовки = Заголовки;
	ЗапросОтправки.УстановитьТелоИзСтроки(ПараметрыЗапросаJSON);
	Ответ = Соединение.ОтправитьДляОбработки(ЗапросОтправки); 	
	Ответ.ПолучитьТелоКакСтроку();  
	
	ЗаполнитьИнформациюОбОбновленииИзInfoResonseИзJSON(Результат, Ответ.ПолучитьТелоКакСтроку());   	
	
	Логин  = "59446-64";
	Пароль = "2036a70d";
	
	ПараметрыЗапросаJSON = UpdateRequestJSON(
		Результат.Конфигурация,
		Результат.Платформа,
		Логин,
		Пароль,
		ДополнительныеПараметрыЗапроса);
		
	ПараметрыОтправки = Новый Структура;
	ПараметрыОтправки.Вставить("Метод"                   , "POST");
	ПараметрыОтправки.Вставить("ФорматОтвета"            , 1);
	ПараметрыОтправки.Вставить("Заголовки"               , Заголовки);
	ПараметрыОтправки.Вставить("ДанныеДляОбработки"      , ПараметрыЗапросаJSON);
	ПараметрыОтправки.Вставить("ФорматДанныхДляОбработки", 1);
	ПараметрыОтправки.Вставить("Таймаут"                 , 30); 
	
	Заголовки = Новый Соответствие();
	Заголовки.Вставить("Content-Type", "application/json");

	Соединение = Новый HTTPСоединение("update-api.1c.ru",,,,,,Новый ЗащищенноеСоединениеOpenSSL());
	ЗапросОтправки = Новый HTTPЗапрос("/update-platform/programs/update/"); 
	ЗапросОтправки.Заголовки = Заголовки;
	ЗапросОтправки.УстановитьТелоИзСтроки(ПараметрыЗапросаJSON);
	Ответ = Соединение.ОтправитьДляОбработки(ЗапросОтправки); 	
	Ответ.ПолучитьТелоКакСтроку(); 
	
	//Получаем номера обновлений  
	ОбновленияКонфигурации = Новый Структура();
	ОбновленияКонфигурации.Вставить("URLФайлаОбновления"                ,"");
	ОбновленияКонфигурации.Вставить("ПодкаталогШаблонов"				,"");
	ОбновленияКонфигурации.Вставить("ОтносительныйПутьCFUФайла"         ,"");
	ОбновленияКонфигурации.Вставить("ПрименитьОбработчикиОбновления"    ,"");
	ОбновленияКонфигурации.Вставить("ФорматФайлаОбновления"           	,"");
	ОбновленияКонфигурации.Вставить("РазмерФайла"      					,"");
	ОбновленияКонфигурации.Вставить("КонтрольнаяСумма"       			,"");
	ОбновленияКонфигурации.Вставить("ПодкаталогCfu"        				,"");
	
	РезультатUpdate = Новый Структура();
	РезультатUpdate.Вставить("ИмяОшибки", "");
	РезультатUpdate.Вставить("Сообщение", "");
	РезультатUpdate.Вставить("ИнформацияОбОшибке", "");
	РезультатUpdate.Вставить("ОбновленияКонфигурации", Новый Массив);
	РезультатUpdate.Вставить("Исправления", Новый Массив);
	РезультатUpdate.Вставить("URLФайлаОбновленияПлатформы", "");
	РезультатUpdate.Вставить("РазмерОбновленияПлатформы", 0); 
	РезультатUpdate.Вставить("ВерсияПлатформы", "");    
	РезультатUpdate.Вставить("ФайлыДляЗагрузки", Новый Массив);

 	ЗаполнитьИнформациюОФайлахОбновленияИзUpdateResonseJSON(РезультатUpdate, Ответ.ПолучитьТелоКакСтроку());
	
	Возврат РезультатUpdate; 
	
КонецФункции

Функция UpdateRequestJSON(
	ОбновлениеКонф,
	ОбновлениеПл,
	Логин,
	Пароль,
	ДопПараметрыЗапроса)
	
	ЗаписьДанныхСообщения = Новый ЗаписьJSON;
	ЗаписьДанныхСообщения.УстановитьСтроку();
	ЗаписьДанныхСообщения.ЗаписатьНачалоОбъекта();
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("upgradeSequence");
	Если ОбновлениеКонф = Неопределено Тогда
		ЗаписьДанныхСообщения.ЗаписатьЗначение(Неопределено);
	Иначе
		ЗаписьДанныхСообщения.ЗаписатьНачалоМассива();
		Для каждого ТекИд Из ОбновлениеКонф.ФайлыДляЗагрузки Цикл
			ЗаписьДанныхСообщения.ЗаписатьЗначение(ТекИд);
		КонецЦикла;
		ЗаписьДанныхСообщения.ЗаписатьКонецМассива();
	КонецЕсли;
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("programVersionUin");
	Если ОбновлениеКонф = Неопределено Тогда
		ЗаписьДанныхСообщения.ЗаписатьЗначение(Неопределено);
	Иначе
		ЗаписьДанныхСообщения.ЗаписатьЗначение(ОбновлениеКонф.ИдентификаторВерсии);
	КонецЕсли;
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("platformDistributionUin");
	Если ОбновлениеПл = Неопределено Тогда
		ЗаписьДанныхСообщения.ЗаписатьЗначение(Неопределено);
	Иначе
		ЗаписьДанныхСообщения.ЗаписатьЗначение(ОбновлениеПл.ИдентификаторФайла);
	КонецЕсли;
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("login");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(Логин);
	
	ЗаписьДанныхСообщения.ЗаписатьИмяСвойства("password");
	ЗаписьДанныхСообщения.ЗаписатьЗначение(Пароль);
	
	ЗаписатьДополнительныеПараметрыЗапроса(ДопПараметрыЗапроса, ЗаписьДанныхСообщения);
	
	ЗаписьДанныхСообщения.ЗаписатьКонецОбъекта();
	
	Возврат ЗаписьДанныхСообщения.Закрыть();
	
КонецФункции

Процедура ЗаполнитьИнформациюОФайлахОбновленияИзUpdateResonseJSON(Результат, ТелоJSON)
	
	ЧтениеОтвета = Новый ЧтениеJSON;
	ЧтениеОтвета.УстановитьСтроку(ТелоJSON);
	
	ТекущийУровень = 0;
	Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
		
		Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.ИмяСвойства И ТекущийУровень = 1 Тогда
			
			ИмяСвойства = ЧтениеОтвета.ТекущееЗначение;
			Если ИмяСвойства = "errorName" Тогда
				
				Результат.ИмяОшибки = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
				
			ИначеЕсли ИмяСвойства = "errorMessage" Тогда
				
				Результат.ИнформацияОбОшибке = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
				Результат.Сообщение          = Результат.ИнформацияОбОшибке;
				
			ИначеЕсли ИмяСвойства = "platformDistributionUrl" И ТекущийУровень = 1 Тогда
				
				Результат.URLФайлаОбновленияПлатформы = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
				
			ИначеЕсли ИмяСвойства = "configurationUpdateDataList" Тогда
				
				ЗаполнитьИнформациюОФайлахОбновленияКонфигурацииИзJSON(Результат, ЧтениеОтвета, ТекущийУровень);
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ЧтениеОтвета.Закрыть();
	
КонецПроцедуры

Процедура ЗаполнитьИнформациюОФайлахОбновленияКонфигурацииИзJSON(Результат, ЧтениеОтвета, ТекущийУровень)
	
	ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень);
	Если ЧтениеОтвета.ТипТекущегоЗначения <> ТипЗначенияJSON.НачалоМассива Тогда
		Возврат;
	КонецЕсли;
	
	Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
		
		Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецМассива Тогда
			Возврат;
			
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.НачалоОбъекта И ТекущийУровень = 2 Тогда
			
			templatePath = "";
			executeUpdateProcess = Ложь;
			updateFileUrl = "";
			updateFileName = "";
			updateFileFormat = "";
			size = 0;
			hashSum = "";
			
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецОбъекта И ТекущийУровень = 1 Тогда
			
			Результат.ОбновленияКонфигурации.Добавить(
				НовыйОбновлениеКонфигурации(
					updateFileUrl,
					templatePath,
					updateFileName,
					executeUpdateProcess,
					updateFileFormat,
					size,
					hashSum));
			
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.ИмяСвойства И ТекущийУровень = 2 Тогда
			
			ИмяСвойства = ЧтениеОтвета.ТекущееЗначение;
			
			Если ИмяСвойства = "templatePath" Тогда
				templatePath = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "executeUpdateProcess" Тогда
				executeUpdateProcess = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, Ложь);
			ИначеЕсли ИмяСвойства = "updateFileUrl" Тогда
				updateFileUrl = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "updateFileName" Тогда
				updateFileName = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "updateFileFormat" Тогда
				updateFileFormat = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "size" Тогда
				size = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, 0);
			ИначеЕсли ИмяСвойства = "hashSum" Тогда
				hashSum = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция НовыйОбновлениеКонфигурации(
	URLФайлаОбновления,
	ПодкаталогШаблонов,
	ОтносительныйПутьCFUФайла,
	ПрименитьОбработчикиОбновления,
	ФорматФайлаОбновления,
	РазмерФайла,
	КонтрольнаяСумма)
	
	Результат = Новый Структура;
	Результат.Вставить("URLФайлаОбновления"            , URLФайлаОбновления);
	Результат.Вставить("ПодкаталогШаблонов"            , ПодкаталогШаблонов);
	Результат.Вставить("ОтносительныйПутьCFUФайла"     , ОтносительныйПутьCFUФайла);
	Результат.Вставить("ПрименитьОбработчикиОбновления", ПрименитьОбработчикиОбновления);
	Результат.Вставить("ФорматФайлаОбновления"         , НРег(ФорматФайлаОбновления));
	Результат.Вставить("РазмерФайла"                   , РазмерФайла);
	Результат.Вставить("КонтрольнаяСумма"              , КонтрольнаяСумма);
	Результат.Вставить("ПодкаталогCfu"                 , КаталогФайлаИзПолногоИмени(ОтносительныйПутьCFUФайла));
	
	Если Прав(ВРег(Результат.ОтносительныйПутьCFUФайла), 4) <> ".CFU" Тогда
		Результат.ОтносительныйПутьCFUФайла = Результат.ОтносительныйПутьCFUФайла + ".cfu";
	КонецЕсли;
	
	Если Прав(Результат.ПодкаталогШаблонов, 1) <> "\" Тогда
		Результат.ПодкаталогШаблонов = Результат.ПодкаталогШаблонов + "\";
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция КаталогФайлаИзПолногоИмени(ПолноеИмяФайла)
	
	ДлинаСтроки = СтрДлина(ПолноеИмяФайла);
	Для Итератор = 0 По ДлинаСтроки - 1 Цикл
		ИндексТекСимвола = ДлинаСтроки - Итератор;
		ТекСимвол = Сред(ПолноеИмяФайла, ИндексТекСимвола, 1);
		Если ТекСимвол = "\" Или ТекСимвол = "/" Тогда
			Возврат Лев(ПолноеИмяФайла, ИндексТекСимвола);
		КонецЕсли;
	КонецЦикла;
	
	Возврат "";
	
КонецФункции

Функция ЧтениеJSONПрочитать(Чтение, ТекущийУровень)
	
	Результат = Чтение.Прочитать();
	Если Чтение.ТипТекущегоЗначения = ТипЗначенияJSON.НачалоОбъекта Тогда
		ТекущийУровень = ТекущийУровень + 1;
	ИначеЕсли Чтение.ТипТекущегоЗначения = ТипЗначенияJSON.КонецОбъекта Тогда
		ТекущийУровень = ТекущийУровень - 1;
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, ЗначениеПоУмолчанию = Неопределено)
	
	ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень);
	Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.Строка
		Или ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.Число
		Или ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.Булево Тогда
		Возврат ЧтениеОтвета.ТекущееЗначение;
	КонецЕсли;
	
	Возврат ЗначениеПоУмолчанию;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьИнформациюОбОбновленииИзInfoResonseИзJSON(Результат, ТелоJSON)
	
	ЧтениеОтвета = Новый ЧтениеJSON;
	ЧтениеОтвета.УстановитьСтроку(ТелоJSON);
	
	ТекущийУровень = 0;
	Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
		
		Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.ИмяСвойства И ТекущийУровень = 1 Тогда
			
			ИмяСвойства = ЧтениеОтвета.ТекущееЗначение;
			Если ИмяСвойства = "errorName" Тогда
				
				Результат.ИмяОшибки = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
				
			ИначеЕсли ИмяСвойства = "errorMessage" Тогда
				
				Результат.ИнформацияОбОшибке = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
				Результат.Сообщение          = Результат.ИнформацияОбОшибке;
				
			ИначеЕсли ИмяСвойства = "configurationUpdateResponse" Тогда
				
				ЗаполнитьИнформациюОбОбновленииКонфигурацииИзJSON(Результат, ЧтениеОтвета, ТекущийУровень, 2);
				
			ИначеЕсли ИмяСвойства = "platformUpdateResponse" Тогда
				
				ЗаполнитьИнформациюОбОбновленииПлатформыИзJSON(Результат, ЧтениеОтвета, ТекущийУровень, 2);
				
			ИначеЕсли ИмяСвойства = "additionalReleaseUpdate" Тогда
				
				ЗаполнитьИнформациюОДополнительныхВерсияхОбновленийИзJSON(Результат, ЧтениеОтвета, ТекущийУровень);
				
			ИначеЕсли ИмяСвойства = "currentReleaseSupportEndDate" Тогда
				
				ДатаСтрокой = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень);
				Если ДатаСтрокой <> Неопределено Тогда
					Результат.ОкончаниеПоддержкиТекущейВерсии = ПрочитатьДатуJSON(ДатаСтрокой, ФорматДатыJSON.ISO);
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
	ЧтениеОтвета.Закрыть();
	
КонецПроцедуры

Процедура ЗаполнитьИнформациюОбОбновленииПлатформыИзJSON(Результат, ЧтениеОтвета, ТекущийУровень, УровеньОбъекта)
	
	ОбновлениеКомПл = Результат.Платформа;
	Если ОбновлениеКомПл = Неопределено Тогда
		// Если обновление платформы не требуется, тогда пропустить.
		Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
			Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецОбъекта Тогда
				Возврат;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень);
	Если ЧтениеОтвета.ТипТекущегоЗначения <> ТипЗначенияJSON.НачалоОбъекта Тогда
		Возврат;
	КонецЕсли;
	
	Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
		
		Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецОбъекта Тогда
			
			Возврат;
			
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.ИмяСвойства
			И ТекущийУровень = УровеньОбъекта Тогда
			
			ИмяСвойства = ЧтениеОтвета.ТекущееЗначение;
			Если ИмяСвойства = "platformVersion" Тогда
				ОбновлениеКомПл.Версия = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "transitionInfoUrl" Тогда
				ОбновлениеКомПл.URLОсобенностиПерехода = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "releaseUrl" Тогда
				ОбновлениеКомПл.URLСтраницыПлатформы = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "distributionUin" Тогда
				ОбновлениеКомПл.ИдентификаторФайла = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "size" Тогда
				ОбновлениеКомПл.РазмерОбновления = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, 0);
			ИначеЕсли ИмяСвойства = "recommended" Тогда
				ОбновлениеКомПл.РекомендуетсяПереход = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, Ложь);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьИнформациюОбОбновленииКонфигурацииИзJSON(Результат, ЧтениеОтвета, ТекущийУровень, УровеньОбъекта)
	
	ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень);
	
	Если ЧтениеОтвета.ТипТекущегоЗначения <> ТипЗначенияJSON.НачалоОбъекта Тогда
		Возврат;
	КонецЕсли;
	
	ОбновлениеКомКонф = Результат.Конфигурация;
	Если ОбновлениеКомКонф = Неопределено Тогда
		// Если обновление конфигурации не требуется, тогда пропустить.
		// Контролируется сервисом, используется для дополнительной проверки.
		Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
			Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецОбъекта Тогда
				Возврат;
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
		
		Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецОбъекта Тогда
			
			Возврат;
			
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.ИмяСвойства
			И ТекущийУровень = УровеньОбъекта Тогда
			
			ИмяСвойства = ЧтениеОтвета.ТекущееЗначение;
			Если ИмяСвойства = "configurationVersion" Тогда
				ОбновлениеКомКонф.Версия = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "size" Тогда
				ОбновлениеКомКонф.РазмерОбновления = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, 0);
			ИначеЕсли ИмяСвойства = "platformVersion" Тогда
				ОбновлениеКомКонф.МинимальнаяВерсияПлатформы = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "updateInfoUrl" Тогда
				ОбновлениеКомКонф.URLНовоеВВерсии = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "howToUpdateInfoUrl" Тогда
				ОбновлениеКомКонф.URLПорядокОбновления = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "programVersionUin" Тогда
				ОбновлениеКомКонф.ИдентификаторВерсии = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень, "");
			ИначеЕсли ИмяСвойства = "supportEndDate" Тогда
				
				ДатаСтрокой = ЗначениеСвойстваJSON(ЧтениеОтвета, ТекущийУровень);
				Если ДатаСтрокой <> Неопределено Тогда
					ОбновлениеКомКонф.ОкончаниеПоддержки = ПрочитатьДатуJSON(ДатаСтрокой, ФорматДатыJSON.ISO);
				КонецЕсли;
				
			ИначеЕсли ИмяСвойства = "upgradeSequence" Тогда
				
				ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень);
				Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.НачалоМассива Тогда
					Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
						Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецМассива Тогда
							Прервать;
						ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.Строка Тогда
							ОбновлениеКомКонф.ФайлыДляЗагрузки.Добавить(ЧтениеОтвета.ТекущееЗначение);
						КонецЕсли;
					КонецЦикла;
				КонецЕсли;
				
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьИнформациюОДополнительныхВерсияхОбновленийИзJSON(Результат, ЧтениеОтвета, ТекущийУровень)
	
	ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень);
	Если ЧтениеОтвета.ТипТекущегоЗначения <> ТипЗначенияJSON.НачалоМассива Тогда
		Возврат;
	КонецЕсли;
	
	ДополнительныеВерсии = Результат.ДополнительныеВерсии;
	Пока ЧтениеJSONПрочитать(ЧтениеОтвета, ТекущийУровень) Цикл
		Если ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.КонецМассива Тогда
			Прервать;
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.НачалоОбъекта Тогда
			
			ДополнительнаяВерсияКонфигурации = ?(
				Результат.Конфигурация = Неопределено,
				Неопределено,
				НовыйИнформацияОДоступномОбновленииКонфигурации());
			ДополнительнаяВерсияПлатформы = ?(
				Результат.Платформа = Неопределено,
				Неопределено,
				НовыйИнформацияОДоступномОбновленииПлатформы());
			
			ДополнительнаяВерсия = Новый Структура();
			ДополнительнаяВерсия.Вставить("Конфигурация", ДополнительнаяВерсияКонфигурации);
			ДополнительнаяВерсия.Вставить("Платформа"   , ДополнительнаяВерсияПлатформы);
			
			ДополнительныеВерсии.Добавить(ДополнительнаяВерсия);
			
		ИначеЕсли ЧтениеОтвета.ТипТекущегоЗначения = ТипЗначенияJSON.ИмяСвойства Тогда
			
			Если ЧтениеОтвета.ТекущееЗначение = "configurationUpdate" Тогда
				ЗаполнитьИнформациюОбОбновленииКонфигурацииИзJSON(
					ДополнительнаяВерсия,
					ЧтениеОтвета,
					ТекущийУровень,
					3);
			ИначеЕсли ЧтениеОтвета.ТекущееЗначение = "platformUpdate" Тогда
				ЗаполнитьИнформациюОбОбновленииПлатформыИзJSON(ДополнительнаяВерсия, ЧтениеОтвета, ТекущийУровень, 3);
			КонецЕсли;
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Функция НовыйИнформацияОДоступномОбновленииКонфигурации()
	
	Результат = Новый Структура;
	Результат.Вставить("Версия"                    , "");
	Результат.Вставить("МинимальнаяВерсияПлатформы", "");
	Результат.Вставить("ФайлыДляЗагрузки"          , Новый Массив);
	Результат.Вставить("РазмерОбновления"          , 0);
	Результат.Вставить("URLНовоеВВерсии"           , "");
	Результат.Вставить("URLПорядокОбновления"      , "");
	Результат.Вставить("ИдентификаторВерсии"       , "");
	Результат.Вставить("ДоступноОбновление"        , Ложь);
	Результат.Вставить("ОкончаниеПоддержки"        , Неопределено);
	
	Возврат Результат;
	
КонецФункции

// Описание объекта с информацией о доступном обновлении платформы.
//
// Возвращаемое значение:
//  Структура:
//    * Версия - Строка
//    * ИдентификаторФайла - Строка
//    * РазмерОбновления - Число - размер файла для загрузки в байтах.
//    * URLОсобенностиПерехода - Строка
//    * URLСтраницыПлатформы - Строка
//    * РекомендуетсяПереход - Булево - Истина, если рекомендуется обновить платформу.
//    * ДоступноОбновление - Булево
//    * ОбязательностьУстановки - Число - вариант установки новой версии платформы. Доступные значения:
//        0 - обновление платформы является обязательным для работы с новой версией конфигурации.
//        1 - новая версия платформы 1С:Предприятие рекомендуется для работы с новой версией конфигурации.
//        2 - обновление платформы не является обязательным для работы с новой версией конфигурации.
//
Функция НовыйИнформацияОДоступномОбновленииПлатформы()
	
	Результат = Новый Структура;
	Результат.Вставить("Версия"                 , "");
	Результат.Вставить("ИдентификаторФайла"     , "");
	Результат.Вставить("РазмерОбновления"       , 0);
	Результат.Вставить("URLОсобенностиПерехода" , "");
	Результат.Вставить("URLСтраницыПлатформы"   , "");
	Результат.Вставить("РекомендуетсяПереход"   , Ложь);
	Результат.Вставить("ДоступноОбновление"     , Ложь);
	Результат.Вставить("ОбязательностьУстановки", 2);
	
	Возврат Результат;
	
КонецФункции


