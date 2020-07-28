From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: RE: About sysfs usage by socket-can drivers
Date: Tue, 28 Jul 2020 13:20:11 +0200
Message-ID: <5E128BFC-17C1-4671-B243-D6E70C3DD10C@vandijck-laurijssen.be>
References: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>,<20200724094502.GB27720@x1.vandijck-laurijssen.be> <VI1PR03MB5053EF45CF182D93B68F3FC4D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relay-b02.edpnet.be ([212.71.1.222]:39688 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgG1LUW (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jul 2020 07:20:22 -0400
In-Reply-To: <VI1PR03MB5053EF45CF182D93B68F3FC4D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 28 July 2020 09:31:52 GMT+02:00, "Stéphane Grosjean" <s.grosjean@peak-system.com> wrote:
>Thx for your answer Kurt! Even if properties are channel related, this
>could be a solution...
>
>But... creating a (new) channel tree under /devices looks weird,
>doesn't it?

/sys/class/net/.... are symlinks to /sys/devices/..., not weird IMO

>And why it should be "easier" to add attributes there rather than under
>each /sys/class/net/can?

Equally easy to add, much simpler to use in udev without race conditions.


>
>-- Stéphane
>
>
>De : Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
>Envoyé : vendredi 24 juillet 2020 11:45
>À : Stéphane Grosjean <s.grosjean@peak-system.com>
>Cc : Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel.org
><linux-can@vger.kernel.org>
>Objet : Re: About sysfs usage by socket-can drivers
>
>> We've several pending requests regarding:
>> - changing the default clock value,
>> - reading the bus load value,
>> - using a flashed device id. to better control the can interface
>number,
>> - identifying the (USB) channel
>> - ...
>
>I tend to look in the (in your case) usb device, and add properties
>there.
>After all, those are device-related properties, not?
>
>You could reach them via /sys/class/net/canX/device/...
>
>If you add them before the netdev is registered, you can use them in
>udev rules without race conditions.
>
>Kurt
>
>--
>PEAK-System Technik GmbH
>Sitz der Gesellschaft Darmstadt - HRB 9183
>Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
>Unsere Datenschutzerklaerung mit wichtigen Hinweisen
>zur Behandlung personenbezogener Daten finden Sie unter
>www.peak-system.com/Datenschutz.483.0.html

Sent from a small mobile device
