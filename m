From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2] can: pcan_usb: don't provide CAN FD bittimings by
 non-FD adapters
Date: Thu, 6 Aug 2015 11:40:45 +0200
Message-ID: <55C32B9D.80704@pengutronix.de>
References: <1438848491-16234-1-git-send-email-mkl@pengutronix.de>
 <55C327C4.7010807@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hmmW96an0Bf2PRSs31mtAwF1naDxBRaT7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57076 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbbHFJlB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Aug 2015 05:41:01 -0400
In-Reply-To: <55C327C4.7010807@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hmmW96an0Bf2PRSs31mtAwF1naDxBRaT7
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/06/2015 11:24 AM, Oliver Hartkopp wrote:
> Hi Marc,
>=20
> On 06.08.2015 10:07, Marc Kleine-Budde wrote:
>> The CAN FD data bittiming constants are provided via netlink only when=
 there
>> are valid CAN FD constants available in priv->data_bittiming_const.
>>
>> Due to the indirection of pointer assignments in the peak_usb driver t=
he
>> priv->data_bittiming_const never becomes NULL - not even for non-FD ad=
apters.
>>
>> The data_bittiming_const points to zero'ed data which leads to this re=
sult
>> when running 'ip -details link show can0':
>>
>> 35: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group=
 default qlen 10
>>      link/can  promiscuity 0
>>      can state STOPPED restart-ms 0
>> 	  pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
>> 	  : dtseg1 0..0 dtseg2 0..0 dsjw 1..0 dbrp 0..0 dbrp-inc 0  <=3D=3D B=
ROKEN!
>> 	  clock 8000000
>>
>> This patch sets the dev_set_data_bittiming in struct peak_adapter to N=
ULL to
>> be able to disable the CAN FD specific information on non-FD adapters.=

>>
>> This patch changes the struct peak_usb_adapter::bittiming_const and st=
ruct
>> peak_usb_adapter::data_bittiming_const to pointers to fix the assignem=
nt
>> problems.
>=20
> I assumed there is an even better solution for the issue.
> Thanks for the rework!
>=20
>>
>> Cc: linux-stable <stable@vger.kernel.org> # > 4.0
>=20
> Should be:
>=20
> Cc: linux-stable <stable@vger.kernel.org> # >=3D 4.0
>=20
>> Reported-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
>=20
> At least with PCAN USB and PCAN USB FD - my 'pro' adapters are at the o=
ffice.
> But I can see no reason why they should not work in the same manner.
>=20
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> picking up Olvier's work. Alternate approach, I've made the
>> peak_usb_adapter::bittiming_const and struct
>> peak_usb_adapter::data_bittiming_const a pointer.
>>
>> Please test,
>=20
> done :-)

Thanks.
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--hmmW96an0Bf2PRSs31mtAwF1naDxBRaT7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJVwyudAAoJEP5prqPJtc/HzTUH/0xOw1ybHXNwPIM/rOtx+nih
4lftasPmWUsVt4r3oWuvMji0W6Pf6LcYg/xMvx1eo6ZmxeYifKSxjo4lc8AlhoOD
mP6xwMdGhK9bdVR4du22EidhEuav5h/kG9wx9HZ8hOFUCXpwmNbc6+sf0EAslQvs
K7KsSX6+/KjD/2jrAK+Mn88K0ZKCZz392NMi/B3d1K3ISunMRklPeosJxy2J1Xgn
KhTO3omXX7ihbgedlqtLZNo+TI8NfXhmcREen3R1lMJjI1YdUTMROQ5RQ9ALR25Y
ZsQeGGfmE7ARYO9Th1COUc1gzxAUs1TavdMuOi6Ao3T5utDrPQN+QWj2VUHuqMk=
=BzLl
-----END PGP SIGNATURE-----

--hmmW96an0Bf2PRSs31mtAwF1naDxBRaT7--
