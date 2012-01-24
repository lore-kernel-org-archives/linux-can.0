From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: About PCAN-USB issues
Date: Tue, 24 Jan 2012 18:12:24 +0100
Message-ID: <4F1EE678.2050604@peak-system.com>
References: <1567213.2GCzMlGyKY@lisa> <4F1E9DA9.9060804@hartkopp.net>
Reply-To: s.grosjean@peak-system.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:38261 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752401Ab2AXRMo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2012 12:12:44 -0500
In-Reply-To: <4F1E9DA9.9060804@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Sebastian Haas <dev@sebastianhaas.info>, Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello all,

I'm finally back to the linux-can... I'm currently working on several=20
projects so the peak_usb did progress slowly these last days...

Back to the issue: I changed the way the can state is handled in the=20
peak_usb driver and finally get an easy tesbed to create bus-off=20
events... Now, the driver puts the candev into that state only once, no=
=20
more periodic error-warnings or else. I'm looking now to how the restar=
t=20
mechanism works.

1st: since the restart can be automatic, the related do_set_mode=20
callback is called from a timer context, in which you're not allowed to=
=20
sleep. So I suppose this is the reason of some Kernel hangs you (Oliver=
)=20
detected last week: the peak_usb driver (tries to) reset the device by=20
sending an usb message, using usb_bulk_msg(), which usage is not allowe=
d=20
in such a context! To confirm, is someone able to do the same with the=20
ems_usb driver, please? It seems that this driver acts as the peak_usb =
does.

Moreover, it seems that the "manual" restart is also called from such a=
=20
timer context, so the consequences are the same...

I'll have to change the way that reset is done into full asynchronous m=
ode.

Regards,

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
