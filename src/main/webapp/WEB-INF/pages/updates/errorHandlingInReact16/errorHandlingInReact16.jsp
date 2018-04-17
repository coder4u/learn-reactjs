<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/updates/errorHandlingInReact16" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>

<c:url var="stackTrace1ImgUrl"
       value="/resources/imges/pages/updates/errorHandlingInReact16/component_stack_trace_1.png"/>
<c:url var="stackTrace2ImgUrl"
       value="/resources/imges/pages/updates/errorHandlingInReact16/component_stack_trace_2.png"/>

<c:url var="createReactAppUrl" value="https://github.com/facebookincubator/create-react-app"/>
<c:url var="transformPluginUrl" value="https://www.npmjs.com/package/babel-plugin-transform-react-jsx-source"/>
<c:url var="codeModeUrl" value="https://github.com/reactjs/react-codemod#error-boundaries"/>

<a name="pageStart"></a>
<lt:layout cssClass="black-line"/>
<lt:layout cssClass="page react-v16.0-page">
	<h1>Обработка ошибок в React 16</h1>

	<wg:p><b>26 Июля, 2017. Dan Abramov(Дэн Абрамов)</b></wg:p>

	<wg:p>По мере приближения версии React 16 мы хотели бы опубликовать несколько изменений,
		касающихся того, как React обрабатывает ошибки JavaScript внутри компонентов. Эти изменения
		включены в бета-версии React 16 и будут частью React 16.</wg:p>

	<h2>Поведение в React 15 и ранее</h2>

	<wg:p>Ранее ошибки JavaScript внутри компонентов, ломали внутреннее состояние React и
		вынуждали его выбрасывать загадочные ошибки на последующих отрисовках. Эти ошибки
		всегда были вызваны более ранней ошибкой в коде приложения. React не предоставлял
		способа их грамотно обработать в компонентах и не мог восстановиться после того,
		как эти ошибки возникли.</wg:p>

	<h2>Знакомство с границами ошибок</h2>

	<wg:p>Ошибка JavaScript в области пользовательского интерфейса не должна ломать все
		приложение. Чтобы решить эту проблему для пользователей React, React 16 представляет
		новую концепцию «<b>граница ошибки</b>».</wg:p>

	<wg:p>Границы ошибок - <b>это компоненты</b> React, которые <b>отлавливают ошибки JavaScript в
		любом месте их дочернего дерева компонентов, регистрируют эти ошибки и отображают
		резервный интерфейс</b> вместо поломанного дерева компонентов. Границы ошибок
		перехватывают ошибки во время отрисовки, в методах жизненного цикла и в
		конструкторах всего дерева под ними.</wg:p>

	<wg:p>Компонент класса становится границей ошибки, если он определяет
		новый метод жизненного цикла, называемый <code>componentDidCatch (error, info)</code>:</wg:p>

	<ce:code-example-1/>

	<wg:p>Затем вы можете использовать его как обычный компонент:</wg:p>

	<ce:code-example-2/>

	<wg:p>Метод <code>componentDidCatch()</code> работает как блок <code>catch {}</code> JavaScript, но для компонентов.
		Только компоненты класса могут являться границами ошибок. На практике вы скорее всего
		предпочтёте объявить компонент границы ошибки один раз и использовать его во всем приложении.</wg:p>

	<wg:p>Обратите внимание, что <b>граница ошибки отлавливает только ошибки в компонентах ниже их в
		дереве</b>. Граница ошибки не может отловить ошибку внутри себя. Если текущая граница ошибки
		проваливает попытку отобразить сообщение об ошибке, ошибка будет распространяться на
		ближайшую границу ошибки выше по дереву иерархии. Это тоже похоже на то, как блок <code>catch {}</code>
		работает в JavaScript.</wg:p>

	<h2>Где устанавливать границы ошибок</h2>

	<wg:p>Расположение границ ошибок зависит от вас. Вы можете обернуть компоненты верхнего
		уровня, чтобы отобразить сообщение типа «Что-то пошло не так» для пользователя, так
		же как серверные фреймворки часто обрабатывают сбои. Вы также можете обернуть
		отдельные виджеты в границу ошибки, чтобы защитить их от поломки остальной части приложения.</wg:p>

	<h2>Новое поведение для необрабатываемых ошибок</h2>

	<wg:p>Это изменение имеет важное значение. Начиная с React 16, ошибки, которые не были
		захвачены какой-либо границей ошибок, приведут к демонтированию всего дерева компонентов React.</wg:p>

	<wg:p>Мы обсуждали это решение, но по нашему опыту полностью удалить поврежденный
		пользовательский интерфейс, чем оставить его видимым. Например, в таком продукте,
		как Messenger, если оставить сломанный пользовательский интерфейс видимым, это
		может привести к тому, что кто-то отправит сообщение не тому человеку.
		Аналогично, для приложения платежей лучше ничего не отображать, чем отображать неправильную сумму.</wg:p>

	<wg:p>Это изменение означает, что как только вы мигрируете на React 16, то, вероятно,
		обнаружите сбои в своем приложении, которые были незаметны раньше. Добавление
		границ ошибок позволяет обеспечить лучший UX, когда что-то пойдет не так.</wg:p>

	<wg:p>Например, Facebook Messenger обертывает содержимое боковой панели, информационной
		панели, журнала беседы и поля ввода сообщения в отдельные границы ошибок.
		Если какой-то компонент в одной из этих областей пользовательского интерфейса ломается,
		остальные продолжают исправно работать.</wg:p>

	<wg:p>Мы также рекомендуем вам использовать сервисы отчетов об ошибках JS (или создать свои собственные),
		чтобы вы могли узнавать о необработанных исключениях, которые происходят в <code>production</code>
		версии, и исправлять их.</wg:p>

	<h2>Трассировка стека компонентов</h2>

	<wg:p>Во время разработки React 16 печатает все ошибки, возникающие при рендеринге в консоль,
		даже если приложение случайно проглатывает их. Помимо сообщения об ошибке и стека
		JavaScript, он также обеспечивает трассировку стека компонентов. Теперь вы можете
		увидеть, где именно в дереве компонентов произошла ошибка:</wg:p>

	<wg:p style="overflow-x: auto">
		<wg:img src="${stackTrace1ImgUrl}"/>
	</wg:p>


	<wg:p>Вы также можете увидеть имена файлов и номера строк в трассировке стека
		компонентов. Это работает по умолчанию в проектах
		<wg:link href="${createReactAppUrl}">Create React App</wg:link>:</wg:p>

	<wg:p style="overflow-x: auto">
		<wg:img src="${stackTrace2ImgUrl}"/>
	</wg:p>

	<wg:p>Если вы не используете приложение <wg:link href="${createReactAppUrl}">Create React App</wg:link>,
		вы можете добавить <wg:link href="${transformPluginUrl}">этот плагин</wg:link> вручную в
		свою конфигурацию Babel. Обратите внимание, что он предназначен только для development версии
		приложения и должен быть отключен в production версии.</wg:p>

	<h2>Почему не try/catch?</h2>

	<wg:p><code>try/catch</code> хорош, но он работает только для императивного кода:</wg:p>

	<ce:code-example-3/>

	<wg:p>Однако компоненты React являются декларативными и указывают, что должно быть отображено:</wg:p>

	<ce:code-example-4/>

	<wg:p>Границы ошибок сохраняют декларативную природу React и ведут себя так, как вы ожидаете.
		Например, даже если ошибка, вызванная setState, происходит в методе <code>componentDidUpdate</code> где-то
		глубоко в дереве, она все равно будет правильно распространяться к ближайшей границе ошибки.</wg:p>

	<h2>Изменения наименований в сравнении с React 15</h2>

	<wg:p>React 15 включал очень ограниченную поддержку границ ошибок с помощью метода:
		<code>unstable_handleError</code>. Этот метод больше не работает, и вам нужно будет заменить
		его на <code>componentDidCatch</code> в вашем коде, начиная с первой 16 бета-версии.</wg:p>

	<wg:p>Для этого изменения мы предоставили <wg:link href="${codeModeUrl}">модификатор кода</wg:link>
		для автоматической миграции.</wg:p>
</lt:layout>

<c:url var="nextPageUrl" value="dom-attributes-in-react-16"/>
<app:page-navigate pageStartAncor="pageStart" nextPageUrl="${nextPageUrl}"/>