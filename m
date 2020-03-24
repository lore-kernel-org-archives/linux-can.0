From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: PCI/PCIe cards and MSI support
Date: Tue, 24 Mar 2020 09:15:29 +0000
Message-ID: <DB6PR03MB30934B5DE1A1B43E7E684937D6F10@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <20200319140127.GD2538@x1.vandijck-laurijssen.be>
 <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
 <375f841b-05a3-f1ab-a582-4796d4448029@pengutronix.de>
 <DB6PR03MB3093D18BB366D78BA9D384D1D6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>,<45fe5f0a-9b74-a673-40e9-c3e361c625d5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr80089.outbound.protection.outlook.com ([40.107.8.89]:6723
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726697AbgCXJQN (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:13 -0400
In-Reply-To: <45fe5f0a-9b74-a673-40e9-c3e361c625d5@pengutronix.de>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

>> When switching in MSI mode, we've noticed that once CAN0 is closed (i.e.=
, once its own interrupt is freed), all other CANs on the same card no long=
er receive interrupts (i.e., the handler is never called
again).

> Is it the free_irq() or the other code called on ifdown? Comment out the =
free_irq() and check what happens.

This issue does exist for peak_pci (SJA1000 PC/PCIe driver) as well as for =
peak_pciefd (CAN FD PC interfaces driver) when MSI mode is requested.

At the moment, free_irq() is called on ifdown in both drivers. That's the c=
ore of the issue. When commented out, the interrupt handler is always calle=
d for the other CANs. But, obvioulsy, ifup(CAN0) now says "RTNETLINK answer=
s: Device or resource busy".

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97











De : Marc Kleine-Budde <mkl@pengutronix.de>

Envoy=E9 : lundi 23 mars 2020 10:35

=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>; Kurt Van Dijck <dev=
.kurt@vandijck-laurijssen.be>

Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : Re: PCI/PCIe cards and MSI support




On 3/23/20 10:25 AM, St=E9phane Grosjean wrote:

> When switching in MSI mode, we've noticed that once CAN0 is closed

> (i.e., once its own interrupt is freed), all other CANs on the same card =
no longer receive interrupts (i.e., the handler is never called again).



Is it the free_irq() or the other code called on ifdown? Comment out the

free_irq() and check what happens.



> This issue doesn't exist when any other CANx then CAN0 is closed.

>

> The reason of this is not clear. What we know is that this issue doesn't

>  exist under Windows for any of our (CAN 2.0 as well as CAN FD) cards. On=
 the contrary, the issue is the same for all of our CAN 2.0 / CAN FD cards =
under Linux.

>

> Up to now, the only workaround we have to run in MSI mode is to

> request_irq() when probing the devices (starting from CAN0) *AND*

> free_irq() in the opposite order (ending with CAN0)  when removing the mo=
dule.

>

> Obvioulsy, enabling/disabling hw interrupts is always done when the can i=
nterface is put to up/down.

>

> The "only" side effect is that all MSI interupt levels allocated by the

> driver are requested, even if their corresponding interfaces are not UP.



Which drivers have this problem?



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
