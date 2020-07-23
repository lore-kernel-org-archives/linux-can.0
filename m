From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: About sysfs usage by socket-can drivers
Date: Thu, 23 Jul 2020 14:50:02 +0000
Message-ID: <VI1PR03MB5053B1FB7A45D4243BD1F095D6760@VI1PR03MB5053.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr60058.outbound.protection.outlook.com ([40.107.6.58]:16514
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726761AbgGWOuG (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 23 Jul 2020 10:50:06 -0400
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Mark,

Thank you for your answer.

We've several pending requests regarding:
- changing the default clock value,
- reading the bus load value,
- using a flashed device id. to better control the can interface number,
- identifying the (USB) channel
- ...

Adding attributes under /sys/class/net/canX (or into a specific/private gro=
up) could be a solution.
---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97







            De: Marc Kleine-Budde
Envoy=E9: Jeudi 23 juillet 2020 15:37
=C0: St=E9phane Grosjean; linux-can@vger.kernel.org
Objet: Re: About sysfs usage by socket-can drivers




On 7/23/20 11:18 AM, St=E9phane Grosjean wrote:

> Are there rules for using network interface sysfs, in particular, can a

> socket-can driver add its own attributes, please?

First let's discuss, why you need a sysfs attribute?

Is there a better way to do this?



Then you have to describe the sysfs entry, e.g.:

Documentation/ABI/testing/sysfs-platform-at91



regards,

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
