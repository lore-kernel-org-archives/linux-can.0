From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: About peak_pci PATH v6.1
Date: Mon, 20 Feb 2012 14:25:18 +0100
Message-ID: <4F4249BE.9090402@peak-system.com>
References: <4F422DA4.1080703@peak-system.com>
 <4F423A2E.3030806@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:56863 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752212Ab2BTNZm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 20 Feb 2012 08:25:42 -0500
In-Reply-To: <4F423A2E.3030806@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 20/02/2012 13:18, Marc Kleine-Budde a =E9crit :
> On 02/20/2012 12:25 PM, Stephane Grosjean wrote:
>> I found that the i2c_transfer() is able to sleep, which is generally
>> *not* a good idea when in an interrupt context...
> Not allowed :)


Yes I do agree... I already had to fight in the past against that=20
function in an other context (embedded arm board) so I first had=20
suspicions using it here... But its code now includes some contextual=20
tests before (trying to) acquire some mutex lock... So, I (too) quickly=
=20
concluded that this function was now allowed in that context... I asked=
=20
the linux-i2c ml and one confirms that this depends on the underlying=20
I2C adapter driver. So to be portable, I did the change accordingly, bu=
t=20
I anxiously wait for any feedback from Oliver! ;-)


>> I hope you will be able to find some time to test that new patch.
>>
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

Ok, so from now, I'll post a serie of patches for the can/sja1000 dir.

> I already added your "add support for PEAK-System PCIe/PCIeC/miniPCI
> cards" patch to can-next/master, but If you now have a better version=
,
> I'll force update the branch.
>
> I just updated can-next/master, so that it doesn't include your patch=
=2E
> Now it get complicated :) In order to test the patches you need Olive=
rs
> unplug fix patch, I send it to David today, and it's not part of
> can-next, yet. For easy testing, I merged linux-can into linux-can-ne=
xt,
> the branch is called "with-can-merge" in the linux-can-next repo. Ple=
ase
> make your patch series based on that branch, I'll apply it to
> linux-can-next/master and ask David to merge net into net-next first,=
 in
> case he hasn't.
>
> Back to your question. Yes, please give us a series of patches, even =
if
> its PCI and USB drivers.

=2E.. well both have nothing in common so if nobody disagrees, I'll kee=
p=20
using two series of patches: one for can/sj1000, the other for peak_usb=
=2E..

=46YI: regarding the peak_usb driver, I still wait for any Ack from the=
=20
linux-usb ml...

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
