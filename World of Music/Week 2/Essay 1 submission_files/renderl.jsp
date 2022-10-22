
Event.observe(document,"dom:loaded", function() {
  $$('a[href*="/webapps/osc-BasicLTI-BB5f3731704cfb1/tool.jsp"]').invoke('observe', 'click', osc_BasicLTI_openBasicLTI);
  $$('a[href*="/webapps/osc-BasicLTI-bb_bb60/tool.jsp"]').invoke('observe', 'click', osc_BasicLTI_openBasicLTI);
  $$('a[href*="/webapps/osc-BasicLTI-bb_bb60/popup"]').invoke('observe', 'click', osc_BasicLTI_popup);
  $$('a[href*="/webapps/osc-BasicLTI-bb_bb60/overlay"]').invoke('observe', 'click', osc_BasicLTI_overlay);
  $$('img[src*="/webapps/osc-BasicLTI-BB5f3731704cfb1/icon.jsp"]').invoke('writeAttribute', 'style', 'max-width: 50px');
});
