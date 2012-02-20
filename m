From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: About peak_pci PATH v6.1
Date: Mon, 20 Feb 2012 12:25:24 +0100
Message-ID: <4F422DA4.1080703@peak-system.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:44751 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752946Ab2BTLZa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2012 06:25:30 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

I found that the i2c_transfer() is able to sleep, which is generally=20
*not* a good idea when in an interrupt context...
So, I changed the delay management with a delayed work mechanism. I=20
successfully tested the change on my testbed, but as you know, this is=20
not the best place for testing...

I hope you will be able to find some time to test that new patch.

@Marc: the peak_pci and peak_pcmcia patches bring modifications to the=20
can/sja1000 dir Kconfig and Makefile, So the apply sequence order is=20
critical (I mean, the peak_pci patch must be applied before the=20
peak_pcmcia, because of lines numbers). How to fix that? I first=20
proposed to use a serie of patches but this was not approved...

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
