import org.owasp.html.HtmlPolicyBuilder;
import org.owasp.html.PolicyFactory;

import java.util.regex.Pattern;

public class TravelSanitizerPolicy {

    public static final PolicyFactory POLICY_DEFINITION = new HtmlPolicyBuilder()
//            .allowStandardUrlProtocols()
//            // Allow title="..." on any element.
//            .allowAttributes("title").globally()
//            // Allow href="..." on <a> elements.
//            .allowAttributes("href").onElements("a")
//            // Defeat link spammers.
//            .requireRelNofollowOnLinks()
//
//            // The align attribute on <p> elements can have any value below.
//            .allowAttributes("align")
//            .matching(true, "center", "left", "right", "justify", "char")
//            .onElements("p")
//            // These elements are allowed.
            .allowElements(
                    "a", "label", "noscript", "h1", "h2", "h3", "h4", "h5", "h6",
                    "p", "i", "b", "u", "strong", "em", "small", "big", "pre", "code",
                    "cite", "samp", "sub", "sup", "strike", "center", "blockquote",
                    "hr", "br", "col", "font", "map", "span", "div", "img",
                    "ul", "ol", "li", "dd", "dt", "dl", "tbody", "thead", "tfoot",
                    "table", "td", "th", "tr", "colgroup", "fieldset", "legend")
            .allowElements("quote", "ecode")
            .toFactory();

}
