From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: About sysfs usage by socket-can drivers
Date: Thu, 23 Jul 2020 19:39:52 +0000
Message-ID: <VI1PR03MB50531E485F82E3FD4D64C459D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db8eur05on2043.outbound.protection.outlook.com ([40.107.20.43]:44588
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbgGWTj6 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Jul 2020 15:39:58 -0400
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi,

>> We've several pending requests regarding:

>> - changing the default clock value,


> The input clock rate for the CAN IP Core?

Yes

>> - reading the bus load value,


>..as calculated by the USB device?

or by the IP core, yes.


>> - using a flashed device id. to better control the can interface number,


>Can you make use of dev_id/dev_port
>https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L=
1687

Ok. I'll check that, thanks.


>> - identifying the (USB) channel


>Does udev offer all needed information? E.g.:

Sorry, nope: identify the USB adapter <=3D> flash the LED (which USB device=
 corresponds to which canX)


>> Adding attributes under /sys/class/net/canX (or into a specific/private =
group) could be a solution.


>Marc

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97







            De: Marc Kleine-Budde
Envoy=E9: Jeudi 23 juillet 2020 17:23
=C0: St=E9phane Grosjean
Cc: linux-can@vger.kernel.org
Objet: Re: About sysfs usage by socket-can drivers




On 7/23/20 4:50 PM, St=E9phane Grosjean wrote:

> We've several pending requests regarding:

> - changing the default clock value,



The input clock rate for the CAN IP Core?



> - reading the bus load value,



..as calculated by the USB device?



> - using a flashed device id. to better control the can interface number,



Can you make use of dev_id/dev_port

https://elixir.bootlin.com/linux/latest/source/include/linux/netdevice.h#L1=
687



> - identifying the (USB) channel



Does udev offer all needed information? E.g.:



    udevadm test /sys/class/net/can0



> Adding attributes under /sys/class/net/canX (or into a specific/private g=
roup) could be a solution.



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
