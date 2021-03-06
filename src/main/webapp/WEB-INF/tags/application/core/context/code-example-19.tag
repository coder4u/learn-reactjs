<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true"%>

<cd:code-example-decorator codePenUrl="${codePenUrl}">
  <pre class="prettyprint">
    <code class="language-javascript">
  class App extends React.Component {
    render() {
      return (
        <cd:hl>&lt;Provider value={{something: 'что-нибудь'}}&gt;</cd:hl>
          &lt;Toolbar /&gt;
        &lt;/Provider&gt;
        );
    }
  }</code>
  </pre>
</cd:code-example-decorator>