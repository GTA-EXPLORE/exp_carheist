function ShowNotification(event)
	AddTextEntry('notification_message', event.message)
	BeginTextCommandThefeedPost('notification_message')
	EndTextCommandThefeedPostMessagetext("CHAR_BLANK_ENTRY", "CHAR_BLANK_ENTRY", false, 0, _("notif_title"), _("notif_subtitle"))
	EndTextCommandThefeedPostTicker(false, true)
end