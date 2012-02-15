From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: About can/usb v4 patches serie
Date: Wed, 15 Feb 2012 21:05:34 +0100
Message-ID: <4F3C100E.2020805@hartkopp.net>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F30F691.5070307@peak-system.com> <4F31238A.9060305@volkswagen.de> <4F3BC408.7050402@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:40468 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755204Ab2BOUFm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 15 Feb 2012 15:05:42 -0500
In-Reply-To: <4F3BC408.7050402@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 15.02.2012 15:41, Stephane Grosjean wrote:

> Le 07/02/2012 14:13, Oliver Hartkopp a =E9crit :

>>
>> peak_usb 2-2:1.0: can5: Tx URB aborted (-2)
>>
>> ten times (what is probably the netdev queue length)
>>
>> So on shutdown and/or unplugging there's something to do too.
>>
>=20
> Did you make any other tests on the USB adapters, please? In other wo=
rds, did
> you find any other issue using the PCAN-USB and PCAN-USB Pro adapters=
?
> I fixed the above issue about -ENOENT errno, so if you didn't find an=
ything
> else, I could post the serie of patches again but also to the linux-u=
sb ml.


Hi Stephane,

i'm sorry but i did not find any time to continue testing.

Btw. as you now fixed the eject issues with PCMCIA/PCIeC and USB adapte=
rs
under load (and i assume you did some more 'unfriendly user' testing) i=
t is a
good time to post the drivers for a final review.

As most of the technical/style-issues have been corrected here on the
linux-can ML a cross-posting to linux-can and the PCMCIA/USB MLs is the=
 next
step to get a feedback from the rest of the relevant community now.

Best regards,
Oliver
