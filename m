From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: About peak_pci PATCH v6.1
Date: Wed, 22 Feb 2012 09:59:59 +0100
Message-ID: <4F44AE8F.4070505@peak-system.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:53857 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab2BVJAI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 22 Feb 2012 04:00:08 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

Thanks for your tests on usb adapters, I'll have a look to these diags.
Did you also plan to test the pciec card under heavy traffic? I would=20
like to close that problem first...

>
> I found that the i2c_transfer() is able to sleep, which is generally =
*not* a good idea when in an interrupt context...
> So, I changed the delay management with a delayed work mechanism. I s=
uccessfully tested the change on my testbed,
 > but as you know, this is not the best place for testing...
>
> I hope you will be able to find some time to test that new patch.
>

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
