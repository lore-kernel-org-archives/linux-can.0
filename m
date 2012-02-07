From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: About can/usb v4 patches serie
Date: Tue, 07 Feb 2012 14:43:58 +0100
Message-ID: <4F312A9E.60506@peak-system.com>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com>
 <4F2FF9EE.1060301@volkswagen.de> <4F30F691.5070307@peak-system.com>
 <4F31238A.9060305@volkswagen.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:34965 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755748Ab2BGNoG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2012 08:44:06 -0500
In-Reply-To: <4F31238A.9060305@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 07/02/2012 14:13, Oliver Hartkopp a =E9crit :
> On 07.02.2012 11:01, Stephane Grosjean wrote:
>
>
>> Meanwhile, I have a look to the deadlock issue in the pcmcia driver=20
>> timer
>> function first...
>
> Yes. Just to be sure this eject problem can generally be solved i=20
> replaced the PEAK PCMCIA card with the EMS PCMCIA card in my setup,=20
> where i only get two removal notifications when pulling the card unde=
r=20
> full rx load.
>

Sorry for the typo but the above issue I talked about concerns the=20
peak_pci driver and the PCIeC card, not the PCMCIA driver!
So please confirm:

- pciec iissue: deadlock occurs during 1xMbps traffic, afaik it occurs=20
with the led timer

- but what about this above "eject" issue, regarding the PCMCIA cards=20
and these removal notifications? Can you give me more explanations, ple=
ase?

> Just one remark upon the USB driver:
>
> I did a
>
> cangen -g0 -i can5
>
> to flood the USB-Pro adapter with outgoing traffic.
>
> When doing an "ifconfig can5 down" i get:
>
>
> peak_usb 2-2:1.0: can5: Tx URB aborted (-2)
>
> ten times (what is probably the netdev queue length)
>

something like this, yes... I forgot that.

Regards,

St=E9phane



--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
