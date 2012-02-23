From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: About peak_pci PATH v6.1
Date: Thu, 23 Feb 2012 16:28:54 +0100
Message-ID: <4F465B36.40904@peak-system.com>
References: <4F422DA4.1080703@peak-system.com>
 <4F423A2E.3030806@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:58921 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2BWP3D (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Feb 2012 10:29:03 -0500
In-Reply-To: <4F423A2E.3030806@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>

Hi Marc,

Le 20/02/2012 13:18, Marc Kleine-Budde a =E9crit :
>> @Marc: the peak_pci and peak_pcmcia patches bring modifications to t=
he
>> can/sja1000 dir Kconfig and Makefile, So the apply sequence order is
>> critical (I mean, the peak_pci patch must be applied before the
>> peak_pcmcia, because of lines numbers). How to fix that? I first
>> proposed to use a serie of patches but this was not approved...
> I think due to my too short answer there was a misunderstanding. IIRC=
 in
> one patch you 1. fixed a problem (which is already in mainline) and 2=
=2E
> introduced a new feature. This is why I asked for separate patches. A=
ll
> changes can still go into a series.
>
> I already added your "add support for PEAK-System PCIe/PCIeC/miniPCI
> cards" patch to can-next/master, but If you now have a better version=
,
> I'll force update the branch.
>

So what's your opinion about that new serie?

0001 which contains Kconfig changes (pci+pciec+pcmcia)
0002 contains peak_pci modifications (+pciec,...)
0002 contains Makefile "pcmcia.o" adding + peak_pcmcia

???

Moreover, is that new format compatible with the previous pci-related=20
patch you pushed before?

Regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
