<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true" %>

<cd:code-example codePenUrl="${codePenUrl}">
    <pre class="prettyprint">
        <code class="language-javascript">
  class Timer extends React.Component {
    <cd:hl>constructor(props) {</cd:hl>
      <cd:hl>super(props);</cd:hl>
      <cd:hl>this.state = {value: 0};</cd:hl>
      <cd:hl>this.INTERVAL = 90;</cd:hl>
    <cd:hl>}</cd:hl>

    <cd:hl>componentDidMount() {</cd:hl>
    <cd:hl>}</cd:hl>

    <cd:hl>componentWillUnmount() {</cd:hl>
    <cd:hl>}</cd:hl></code>
    </pre>
</cd:code-example>