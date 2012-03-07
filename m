From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: can: usb: PEAK-System Technik PCAN-USB specific part
Date: Wed, 07 Mar 2012 09:56:36 +0100
Message-ID: <4F5722C4.7030804@peak-system.com>
References: <20120306112108.GA4362@elgon.mountain>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:34207 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab2CGI4n (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 7 Mar 2012 03:56:43 -0500
In-Reply-To: <20120306112108.GA4362@elgon.mountain>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi everybody,

Happy to have seen some of you last Monday, at iCC, it was great. It's=20
always easier when we're able to attach a face to a name.

Back to work now:

Le 06/03/2012 12:21, Dan Carpenter a =E9crit :
> Hello Stephane Grosjean,
>
> The patch 46be265d3388: "can: usb: PEAK-System Technik PCAN-USB
> specific part" from Mar 2, 2012, leads to the following warning:
>
> drivers/net/can/usb/peak_usb/pcan_usb.c:751 pcan_usb_encode_msg()
> 	 error: wrong number of bits for 'cpu_to_le32' (16 vs 32)
>
> drivers/net/can/usb/peak_usb/pcan_usb.c
>     742          /* can id */
>     743          if (cf->can_id&  CAN_EFF_FLAG) {
>     744                  __le32 tmp32 =3D cpu_to_le32(cf->can_id&  CA=
N_ERR_MASK);
>     745
>     746                  tmp32<<=3D 3;
>     747                  *pc |=3D PCAN_USB_STATUSLEN_EXT_ID;
>     748                  memcpy(++pc,&tmp32, 4);
>     749                  pc +=3D 4;
>     750          } else {
>     751                  __le16 tmp16 =3D cpu_to_le32(cf->can_id&  CA=
N_ERR_MASK);
>                          ^^^^^^^^^^^^
> A little endian 32 bit can't fit here.


How may this error happen while it didn't before? Is this is due to som=
e=20
(new) options of gcc, or because of a new version used? In the future,=20
how could I avoid that? I mean, how to synchronize with the final GCC=20
options/version?

=46YI, the original code was:

> >  +	else {
> } else {
> >  +		u16 tmp16 =3D (u16 )*cpu_to_le32*(cf->can_id&  CAN_ERR_MASK);
>                              ^^^^^^^^^^^^^^^^^

cf->can_id is a 32-bits field which I want to keep only the lo-word par=
t...

How to do that in the correct way, please?

Anyway, what next? I suppose I have to submit a new patch, but comparin=
g=20
to what?

Thanks for your help and regards,

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
