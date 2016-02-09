From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Can utils for CANFD
Date: Tue, 9 Feb 2016 13:12:07 +0100
Message-ID: <zarafa.56b9d797.4efd.4bf396903baafa90@euve35974.vserver.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from euve35974.vserver.de ([62.75.213.146]:52104 "EHLO
	euve35974.vserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755932AbcBIMVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 9 Feb 2016 07:21:22 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?Naga_Sureshkumar_Relli?= <naga.sureshkumar.relli@xilinx.com>
Cc: =?utf-8?Q?Appana_Durga_Kedareswara_Rao?= <appanad@xilinx.com>

Hello Naga,

last time I've used CAN-FD with a Peak USB-FD connected to my BeagleBon=
e Black I'm using these sources:

https://github.com/hartkopp/can-utils

Regards
Michael

-----Urspr=C3=BCngliche Nachricht-----
Von:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Gesendet:	Di 09.02.2016 12:58
Betreff:	Can utils for CANFD
An:	linux-can@vger.kernel.org;=20
CC:	Appana Durga Kedareswara Rao <appanad@xilinx.com>;=20
> Hi Marc,
>=20
> I am adding Xilinx_canfd driver for Xilinx CANFD IP.
> So to test that, I have downloaded https://github.com/linux-can/can-u=
tils.
>=20
> But it doesn't have canconfig option, to configure CANFD Controller. =
Like=20
> bitrate, mode etc...
>=20
> It has only ip command support, but this ip utility doesn't have supp=
ort to=20
> change can mode (Normal operation Mode).
> It has only loopback mode support.
>=20
> So, the can-utils, which I am using are the correct utils or not?
>=20
> Suggest me, which one to use, to test CANFD.
>=20
> Thanks,
> Naga Sureshkumar Relli.
>=20
>=20
> This email and any attachments are intended for the sole use of the n=
amed=20
> recipient(s) and contain(s) confidential information that may be prop=
rietary,=20
> privileged or copyrighted under applicable law. If you are not the in=
tended=20
> recipient, do not read, copy, or forward this email message or any at=
tachments.=20
> Delete this email message and any attachments immediately.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
