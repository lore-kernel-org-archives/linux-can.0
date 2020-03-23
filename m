From: =?iso-8859-1?Q?St=E9phane_Grosjean?= <s.grosjean@peak-system.com>
Subject: RE: PCI/PCIe cards and MSI support
Date: Mon, 23 Mar 2020 08:33:56 +0000
Message-ID: <DB6PR03MB3093B3487EC5FCFBFCDB4D6AD6F00@DB6PR03MB3093.eurprd03.prod.outlook.com>
References: <DB6PR03MB3093A117F99170BDD81CBC1FD6F40@DB6PR03MB3093.eurprd03.prod.outlook.com>,<20200319140127.GD2538@x1.vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-eopbgr30069.outbound.protection.outlook.com ([40.107.3.69]:49280
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727534AbgCWIeC (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 23 Mar 2020 04:34:02 -0400
In-Reply-To: <20200319140127.GD2538@x1.vandijck-laurijssen.be>
Content-Language: fr-FR
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Kurt,

Thank you for your reply.

> This seems a bad idea. Loading the module should not allocate resources.
> A reasonable point IMHO is the probe of a device.

That's what I was thinking, sorry for the approximation and misunderstandin=
g. So, you confirm that I can modify the driver to request_irq() when probi=
ng the CAN channels one after the other rather than when these are opened?

Regards,

---
St=E9phane Grosjean
PEAK-System France
132, rue Andr=E9 Bisiaux
F-54320 MAXEVILLE
T=E9l : +(33) 9.72.54.51.97











De : Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

Envoy=E9 : jeudi 19 mars 2020 15:01

=C0 : St=E9phane Grosjean <s.grosjean@peak-system.com>

Cc : linux-can@vger.kernel.org <linux-can@vger.kernel.org>

Objet : Re: PCI/PCIe cards and MSI support




Hey,



> or if the driver can decide to request (resp. free) IRQs when loading (re=
sp. unloading)

> the module?



This seems a bad idea. Loading the module should not allocate resources.

A reasonable point IMHO is the probe of a device.



Kurt


--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183
Geschaeftsfuehrung: Alexander Gach / Uwe Wilhelm
Unsere Datenschutzerklaerung mit wichtigen Hinweisen
zur Behandlung personenbezogener Daten finden Sie unter
www.peak-system.com/Datenschutz.483.0.html
