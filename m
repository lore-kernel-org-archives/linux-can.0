From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: About sysfs usage by socket-can drivers
Date: Tue, 28 Jul 2020 07:31:52 +0000
Message-ID: <VI1PR03MB5053EF45CF182D93B68F3FC4D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>,<20200724094502.GB27720@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db8eur05on2077.outbound.protection.outlook.com ([40.107.20.77]:4928
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726990AbgG1Hb5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 Jul 2020 03:31:57 -0400
In-Reply-To: <20200724094502.GB27720@x1.vandijck-laurijssen.be>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Thx for your answer Kurt! Even if properties are channel related, this coul=
d be a solution...

But... creating a (new) channel tree under /devices looks weird, doesn't it=
?
And why it should be "easier" to add attributes there rather than under eac=
h /sys/class/net/can?

-- St=E9phane


De : Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Envoy=E9 : vendredi 24 juillet 2020 11:45
=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>
Cc : Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel.org <lin=
ux-can@vger.kernel.org>
Objet : Re: About sysfs usage by socket-can drivers

> We've several pending requests regarding:
> - changing the default clock value,
> - reading the bus load value,
> - using a flashed device id. to better control the can interface number,
> - identifying the (USB) channel
> - ...

I tend to look in the (in your case) usb device, and add properties there.
After all, those are device-related properties, not?

You could reach them via /sys/class/net/canX/device/...

If you add them before the netdev is registered, you can use them in
udev rules without race conditions.

Kurt

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
