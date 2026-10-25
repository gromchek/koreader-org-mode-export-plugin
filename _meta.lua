local _ = require("gettext")

return {
    name = "provider_org_exporter",
    fullname = _("Org-mode Exporter"),
    description = _([[
Adds Org-mode (.org) as an export target in the Exporter plugin.

Highlights and notes are saved as a structured Org-mode file:
  * Book title — top-level heading
  ** Chapter — second-level heading
  *** Page N <date> — third-level heading
  #+begin_quote ... #+end_quote — highlighted text
  /Note:/ ... — your annotation

Files are saved to: koreader/clipboard/
]]),
}
