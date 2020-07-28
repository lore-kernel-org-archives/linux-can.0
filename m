From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: About sysfs usage by socket-can drivers
Date: Tue, 28 Jul 2020 07:53:33 +0000
Message-ID: <VI1PR03MB5053BD184B309045AD7336D2D6730@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr80083.outbound.protection.outlook.com ([40.107.8.83]:28674
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728037AbgG1Hxg (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 28 Jul 2020 03:53:36 -0400
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

> Can you query the possible clock rates? Either add to ethtool

Yes the available clock rates list can be provided (by the driver). How to =
do that through ethtool please?

> or make it a CAN specific callback.

Do you propose to extend "struct can_priv" so that the clock could be selec=
tect from netlink?

-- St=E9phane




            De: Marc Kleine-Budde
Envoy=E9: Jeudi 23 juillet 2020 22:13
=C0: St=E9phane Grosjean
Cc: linux-can@vger.kernel.org
Objet: Re: About sysfs usage by socket-can drivers




On 7/23/20 9:39 PM, St=E9phane Grosjean wrote:

>>> - changing the default clock value,

>

>> The input clock rate for the CAN IP Core?

> Yes



Can you query the possible clock rates? Either add to ethtool or make it a =
CAN

specific callback.



>>> - reading the bus load value,

>> ..as calculated by the USB device?

>

> or by the IP core, yes.



maybe we can add this to ethtool's stats, otherwise to the CAN stats.



>>> - using a flashed device id. to better control the can interface number=
,

>

>> Can you make use of dev_id/dev_port

>> https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h=
#L1687

>

> Ok. I'll check that, thanks.

>

>

>>> - identifying the (USB) channel

>

>> Does udev offer all needed information? E.g.:

>

> Sorry, nope: identify the USB adapter <=3D> flash the LED (which USB devi=
ce corresponds to which canX)



Use ethtool's set_phys_id for this:



https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/gs_usb.c=
#L762



You can either implement a "activate blink", "deactivate blink" or "switch =
LED

on", "switch LED off" (and I think the core will take care of blinking).



Marc



--

Pengutronix e.K.                 | Marc Kleine-Budde           |

Embedded Linux                   | https://www.pengutronix.de  |

Vertretung West/Dortmund         | Phone: +49-231-2826-924     |

Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |






--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
