From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: PCI/PCIe cards and MSI support
Date: Thu, 19 Mar 2020 10:53:51 +0000
Message-ID: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am6eur05on2069.outbound.protection.outlook.com ([40.107.22.69]:6142
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726188AbgCSKxz (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 19 Mar 2020 06:53:55 -0400
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello everyone,

I hope everyone is well and that the health of your loved ones is just as g=
ood.

I just want to know if the rule applied in the socket-can layer that a driv=
er calls request_irq() (resp. free_irq()) only when the interface is set UP=
 (resp. DOWN) is an unchangeable rule, or if the driver can decide to reque=
st (resp. free) IRQs when loading (resp. unloading) the module?

Note that this rule currently prevents us from easily implementing MSI supp=
ort in our PCI/PCIe drivers.

Best regards,

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
