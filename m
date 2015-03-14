From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 2/5] can: kvaser_usb: Read all messages in a
 bulk-in URB buffer
Date: Sat, 14 Mar 2015 15:26:57 +0100
Message-ID: <55044531.5060105@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150226152202.GB6075@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="AvGmbbhVlG7K8acV3u0JGGFeHXu6il6QD"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40617 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752527AbbCNO1K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 14 Mar 2015 10:27:10 -0400
In-Reply-To: <20150226152202.GB6075@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>, Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>, Linux-USB <linux-usb@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvGmbbhVlG7K8acV3u0JGGFeHXu6il6QD
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2015 04:22 PM, Ahmed S. Darwish wrote:
> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>=20
> The Kvaser firmware can only read and write messages that are
> not crossing the USB endpoint's wMaxPacketSize boundary. While
> receiving commands from the CAN device, if the next command in
> the same URB buffer crossed that max packet size boundary, the
> firmware puts a zero-length placeholder command in its place
> then moves the real command to the next boundary mark.
>=20
> The driver did not recognize such behavior, leading to missing
> a good number of rx events during a heavy rx load session.
>=20
> Moreover, a tx URB context only gets freed upon receiving its
> respective tx ACK event. Over time, the free tx URB contexts
> pool gets depleted due to the missing ACK events. Consequently,
> the netif transmission queue gets __permanently__ stopped; no
> frames could be sent again except after restarting the CAN
> newtwork interface.
>=20
> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>

Can you please send a fix for this endianess errors (against
linux-can-fixes-for-4.0-20150314):

> drivers/net/can/usb/kvaser_usb.c:595:39: warning: restricted __le16 deg=
rades to integer
> drivers/net/can/usb/kvaser_usb.c:1332:31: warning: restricted __le16 de=
grades to integer

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--AvGmbbhVlG7K8acV3u0JGGFeHXu6il6QD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVBEU3AAoJECte4hHFiupUbYYP/R4Pf5X3BUDsBqTEZ3ohbCNv
agDO0+ixCeljHX2Tgx3vo9kbhiIdN6o9kFJ5j4nGTKQ7XPfT/c1ysxiVwyjvibhF
FpyITDl6dYkyEPZVCnliIQu4EGrlGj5FwBrYxPG64kD21Vm1d0tKpV0AWkp4rMNo
j6fyxYq0wmtvbTsVKyjFrcyVX0NJKT/AgHY3iv/NoU/aK6f0/p2ZilugNCXhMZ19
wrtEcMQ9a16ncZ2IhhAxz9o+gXqckbhgn/TeXYx5960RYXF2+oC6rv52GRIJB4NN
ISx7mU7Ec5pGJ6WtBM8ouN0hex0P318aH/020k5PWJbL312zDFMYNRrNm+gMuEqS
9Dv6jOc/n9DgPdXf0ThBPvoFQHaVBI5qSbvsAhpUv16fzuuh2d7i4zbLE+K6XNW6
9vmUvmPuLYKhkTZFTN7aJR9FLxAFDicRofWqp2b+aqIwW6C2df4be8RbElTv+vtU
UL1tVseFzU13AIbi125J88znCpDE1Q2+fHuOZ5RdAn1v2aQm/7e0+jRbjHbQQpib
QOwAUZZbm1gxJsvTAMHds/h5ndFvLkNFNs2QaaZaAEVbMjURPdyrw72vH+IXtjfx
+sI6uF5P6J9Ej5OQQNmKk2RHlysnMYtxXwF/p2eK/yPDSPSlvlqqFweDUgkxXsj7
yT49coPbTVIqTE92Ndg3
=4RFi
-----END PGP SIGNATURE-----

--AvGmbbhVlG7K8acV3u0JGGFeHXu6il6QD--
