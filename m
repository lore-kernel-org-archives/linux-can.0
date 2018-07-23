From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
Date: Mon, 23 Jul 2018 13:37:05 +0200
Message-ID: <4f81e688-3d5c-6174-5a76-f416ced63cf3@pengutronix.de>
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="CYd92fr6Im77ah3rPQNlYeupNaMHLpxhz"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Nicholas Mc Guire <hofrat@osadl.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CYd92fr6Im77ah3rPQNlYeupNaMHLpxhz
Content-Type: multipart/mixed; boundary="WU7o9dCft5RS9UeJIO1ECOuWy2NrLNbI0";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>, Nicholas Mc Guire <hofrat@osadl.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>,
 "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
 netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <4f81e688-3d5c-6174-5a76-f416ced63cf3@pengutronix.de>
Subject: Re: [PATCH] can: mpc5xxx_can: check of_iomap return before use
References: <1531163800-12111-1-git-send-email-hofrat@osadl.org>
 <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>
In-Reply-To: <CAOMZO5CPVx_3kj5xKaoNbYP14cgPk9aSniyu44oWF-0jbSx91g@mail.gmail.com>

--WU7o9dCft5RS9UeJIO1ECOuWy2NrLNbI0
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 07/09/2018 09:28 PM, Fabio Estevam wrote:
> On Mon, Jul 9, 2018 at 4:16 PM, Nicholas Mc Guire <hofrat@osadl.org> wr=
ote:
>>  of_iompa() can return NULL so that return needs to be checked and NUL=
L
>=20
> s/of_iompa/of_iomap/
>=20
>> treated as failure. While at it also take care of the missing
>> of_node_put() in the error path.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>> Fixes: commit afa17a500a36 ("net/can: add driver for mscan family & mp=
c52xx_mscan")
>> ---
>>
>> Problem was found by an experimental coccinelle script
>>
>> Patch was compiletested with: mpc5200_defconfig + CONFIG_CAN=3Dy,
>> CONFIG_CAN_MSCAN=3Dy, CONFIG_CAN_MPC5XXX=3Dy
>> (with a number of sparse warnings not related to the proposed change)
>>
>> Patch is against 4.18-rc3 (localversion-next is next-20180706)
>>
>>  drivers/net/can/mscan/mpc5xxx_can.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/net/can/mscan/mpc5xxx_can.c b/drivers/net/can/msc=
an/mpc5xxx_can.c
>> index c7427bd..2949a38 100644
>> --- a/drivers/net/can/mscan/mpc5xxx_can.c
>> +++ b/drivers/net/can/mscan/mpc5xxx_can.c
>> @@ -86,6 +86,11 @@ static u32 mpc52xx_can_get_clock(struct platform_de=
vice *ofdev,
>>                 return 0;
>>         }
>>         cdm =3D of_iomap(np_cdm, 0);
>> +       if (!cdm) {
>> +               of_node_put(np_cdm);
>> +               dev_err(&ofdev->dev, "can't map clock node!\n");
>> +               return 0;
>=20
> I think you should return an error code here. -ENOMEM maybe?

Can you send an updated version?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WU7o9dCft5RS9UeJIO1ECOuWy2NrLNbI0--

--CYd92fr6Im77ah3rPQNlYeupNaMHLpxhz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAltVveEACgkQk9IU1zQo
ZfGwWQf/WypR2kyAU25zMRtNX2tHTDZWIR44P6WiSJbKqk27avrJmjzgRMUa9o1i
wYI7ZIwvoprqaiDYCvzN6aSkDj7w+egNahMwQ9oE9IyF9wpruQ7L9KUp16MnjbTA
qsoKc90BUI29csl0Q5Ve8uxyjqQ//VC8aedsYQYzkzJGVyFSZDrPFH3LXQfCBbTh
DTNhiXz1c9QYd82zJEceF9abzyqoDET5dgYsh/Mz6jqOF5eqhq6peG59v17AufUC
pqQbbjKE39CxiwzQQ4rIsL4G/B2VOfZcBbJwgATP5Z+mKmNbIPwhX8nIk4NULLCT
ov8RoRVyrtfGgdUrnBn9MmUzNgHHTg==
=Ey82
-----END PGP SIGNATURE-----

--CYd92fr6Im77ah3rPQNlYeupNaMHLpxhz--
