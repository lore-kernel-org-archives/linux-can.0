From: Olivier Sobrie <olivier@sobrie.be>
Subject: Re: Kvaser USB CAN II support in Linux Kernel
Date: Tue, 26 Aug 2014 14:19:55 +0200
Message-ID: <20140826121955.GA10926@hposo>
References: <CAG+qKUtVvJ2RZC+FzzSU91-fSu01nFK1T+_BVE2ytP=VuOc+ag@mail.gmail.com>
Reply-To: Olivier Sobrie <olivier@sobrie.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48414 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757527AbaHZMUV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 26 Aug 2014 08:20:21 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so4075399wib.16
        for <linux-can@vger.kernel.org>; Tue, 26 Aug 2014 05:20:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAG+qKUtVvJ2RZC+FzzSU91-fSu01nFK1T+_BVE2ytP=VuOc+ag@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeremy Conners <jeremy.conners@gmail.com>
Cc: mkl@pengutronix.de, pgarnero@visteon.com, linux-can@vger.kernel.org, socketcan@hartkopp.net

Hi Jeremy,

On Mon, Aug 25, 2014 at 02:27:15PM -0700, Jeremy Conners wrote:
> Hello gentlemen,
>=20
> I've been working on a project recently with an embedded linux device=
 that
> needs to interface with a J1939/N2K bus. =A0For initial bring-up, I'm=
 using a
> Kvaser USB CAN II device. =A0I recently found this thread (http://
> comments.gmane.org/gmane.network.socketcan.user/1445) that was very h=
elpful to
> get the kernel to recognize the device and properly create the can0/1=
 devices.
> =A0Where can I join the discussion/mailing list as it seems to have b=
een shutdown
> or moved recently? =A0I also may be able to help contribute to the di=
scussion and
> /or help with additional work on this driver as I have a vested inter=
est in
> getting this all running.

The linux-can mailing list (linux-can@vger.kernel.org) is the right pla=
ce
to discuss such things.

Concerning the support for your device, as Pierre stated in the thread,
there are two families of Kvaser devices: "leaf" and "usbII".
Currently only the "leaf" family is supported by the driver in the kern=
el.
Pierre did a copy of kvaser_usb.c and adapted it to make it work with w=
ork
_only_ "usbII" devices. He sent the adapted driver as an attachment
(kvaser_usb2.c).

If you compare the two drivers (kvaser_usb2.c and kvaser_usb.c), you wi=
ll
see that there are not a lot of differences between the two. I think
the best would be to adapt kvaser_usb.c to support both "leaf" and "usb=
II"
devices.
I've one such device at home but I have not had the time yet to have a =
look
at this... So if you want to adapt the driver, you're welcome :-)

Kind regards,

--=20
Olivier
