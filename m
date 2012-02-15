From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: About can/usb v4 patches serie
Date: Wed, 15 Feb 2012 15:41:12 +0100
Message-ID: <4F3BC408.7050402@peak-system.com>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com>
 <4F2FF9EE.1060301@volkswagen.de> <4F30F691.5070307@peak-system.com>
 <4F31238A.9060305@volkswagen.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41834 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758451Ab2BOOlW (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 09:41:22 -0500
In-Reply-To: <4F31238A.9060305@volkswagen.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hi Oliver,

Le 07/02/2012 14:13, Oliver Hartkopp a =E9crit :
> i thought i used the latest version you sent with the tar-ball.
>
> But having a clean version from the mailing list is always a better=20
> starting point for tests ;-)
>
>> This
>> version should handle restart mechanism in a (more) correct way, for=
=20
>> both
>> pcan-usb/pcan-us pro adapters now.
>
> ok.
>
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
> So on shutdown and/or unplugging there's something to do too.
>

Did you make any other tests on the USB adapters, please? In other=20
words, did you find any other issue using the PCAN-USB and PCAN-USB Pro=
=20
adapters?
I fixed the above issue about -ENOENT errno, so if you didn't find=20
anything else, I could post the serie of patches again but also to the=20
linux-usb ml.

Thanks for your reply,

> Best regards,
> Oliver

Best regards,

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
