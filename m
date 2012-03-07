From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 12:16:52 +0100
Message-ID: <4F5743A4.3040205@peak-system.com>
References: <20120306112108.GA4362@elgon.mountain>
 <4F5722C4.7030804@peak-system.com> <4F572949.9000906@pengutronix.de>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43882 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab2CGLQ7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 06:16:59 -0500
In-Reply-To: <4F572949.9000906@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Le 07/03/2012 10:24, Marc Kleine-Budde a =E9crit :
> On 03/07/2012 09:56 AM, Stephane Grosjean wrote:
> Le 06/03/2012 12:21, Dan Carpenter a =E9crit :
>>> Hello Stephane Grosjean,
>>>
>>> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB
>>> specific part" from Mar 2, 2012, leads to the following warning:
>>>
>>> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
>>>       error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>>>
>>> drivers/net/can/usb/peak_usb/pcan_usb.c
>>>      742          /* can id */
>>>      743          if (cf->can_id&   CAN_EFF_FLAG) {
>>>      744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id&
>>> CAN_ERR_MASK);
>>>      745
>>>      746                  tmp32<<=3D 3;
>>>      747                  *pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>>>      748                  memcpy(++pc,&tmp32, 4);
>>>      749                  pc +=3D 4;
>>>      750          } else {
>>>      751                  __le16 tmp16 =3D cpu_to_le32(cf->can_id&
>>> CAN_ERR_MASK);
>>>                           ^^^^^^^^^^^^
>>> A little endian 32 bit can't fit here.
>>
>> How may this error happen while it didn't before? Is this is due to =
some
>> (new) options of gcc, or because of a new version used? In the futur=
e,
>> how could I avoid that? I mean, how to synchronize with the final GC=
C
>> options/version?
> There's no final gcc version. Gcc and the kernel will always evolve.


Yes I know, this is Ok... But the question is: how did that guy manage=20
to get that error? I "git pull"ed my own linux-can-next then rebuilt my=
=20
drivers and don't even see that error!
I suppose that he set some flags somewhere in the Kernel Makefile(s),=20
but where? How can I know whether my next patch will fail or not in his=
=20
configuration?

Thanks for your reply,

St=E9phane


--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
