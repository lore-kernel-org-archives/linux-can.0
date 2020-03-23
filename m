From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: PCI/PCIe cards and MSI support
Date: Mon, 23 Mar 2020 09:25:23 +0000
Message-ID: <DB6PR03MB3093D18BB366D78BA9D384D1D6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <20200319140127.GD2538@x1.vandijck-laurijssen.be>
 <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>,<375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:21646
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727669AbgCWJZ2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 05:25:28 -0400
In-Reply-To: <375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Marc,

When switching in MSI mode, we've noticed that once CAN0 is closed
(i.e., once its own interrupt is freed), all other CANs on the same card no=
 longer receive interrupts (i.e., the handler is never called again).

This issue doesn't exist when any other CANx then CAN0 is closed.

The reason of this is not clear. What we know is that this issue doesn't
 exist under Windows for any of our (CAN 2.0 as well as CAN FD) cards. On t=
he contrary, the issue is the same for all of our CAN 2.0 / CAN FD cards un=
der Linux.

Up to now, the only workaround we have to run in MSI mode is to
request_irq() when probing the devices (starting from CAN0) *AND*
free_irq() in the opposite order (ending with CAN0)  when removing the modu=
le.

Obvioulsy, enabling/disabling hw interrupts is always done when the can int=
erface is put to up/down.

The "only" side effect is that all MSI interupt levels allocated by the
driver are requested, even if their corresponding interfaces are not UP.

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97



De : Marc Kleine-Budde <mkl@pengutronix.de>

Envoy=E9 : lundi 23 mars 2020 09:38

=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>; Kurt Van Dijck <dev=
.kurt@vandijck-laurijssen.be>

Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : Re: PCI/PCIe cards and MSI support




On 3/23/20 9:33 AM, St=E9phane Grosjean wrote:

>> This seems a bad idea. Loading the module should not allocate resources.

>> A reasonable point IMHO is the probe of a device.

>

> That's what I was thinking, sorry for the approximation and

> misunderstanding. So, you confirm that I can modify the driver to

> request_irq() when probing the CAN channels one after the other

> rather than when these are opened?



Why exactly do you need to do this?



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
