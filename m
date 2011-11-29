From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: getting the fill level of rx and tx fifos
Date: Tue, 29 Nov 2011 15:33:20 +0100
Message-ID: <4ED4ED30.4010904@grandegger.com>
References: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2C105@SBSPORT.portnet.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33020 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755436Ab1K2OdY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 29 Nov 2011 09:33:24 -0500
In-Reply-To: <B3B3BE5A55ED7743A83865E234A22B1D1B91F2C105@SBSPORT.portnet.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Cc: "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 11/29/2011 12:25 PM, Heinz-J=FCrgen Oertel wrote:
> Hello,
> reading can.txt and list emails I could not  manage to get this infor=
mation.
> Can please someone explain if and how it is possible to get this info=
rmation.
> I need to know how many frames are still in the net layer and not yet=
 handled by the application.
> And as well importand, how many not yet sent CAN Frames are in the so=
cket layer or the driver.=20

CAN messages are queued as skb's in the socket's receive and send
buffer. What counts is the *total* size of the skb, which requires more
space than a CAN frame, of course. For CAN I do not know of any
interface allowing to retreive the fill level. But other protocols seem
to have something like that, e.g. AF_PACKET provides ioctl request:

#define SIOCINQ  FIONREAD
#define SIOCOUTQ TIOCOUTQ /* output queue size (not sent + not acked) *=
/

> Mit freundlichen Gr=FC=DFen / With best regards
>=20
> Heinz=20
>=20
> PS:
> I saw in candump.c getsockopt(fd, SO_SOCKET, SO_RCVBUF, &rcvbuf_size,=
=2E...)
> Is used.
> But what does the result mean?
> I get large numbers here : 124928

It means that there is space for "124928 / sizeof(skb)" skb's =3D=3D
messages. I will try to find out the overhead later today.

Wolfgang.
