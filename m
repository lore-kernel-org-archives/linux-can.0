From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC, PATCH v2] can: add CAN interface API for fixed bitrates
Date: Fri, 13 Jan 2017 11:30:14 +0100
Message-ID: <bb5de699-d374-3552-b2c0-eca5db55feaa@pengutronix.de>
References: <20170111161003.14506-1-mkl@pengutronix.de>
 <CAKT-o-dudc56=0GV0EHJWXjGAtNxavzKNq+dWSrttJ2o52_A1A@mail.gmail.com>
 <083932d1-2ec6-11a2-9e06-fb23c1bd9694@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="jvkfOLIeDQcdnJmAtQAATH5bIiHqXOMq1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:59249 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751363AbdAMKa0 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 05:30:26 -0500
In-Reply-To: <083932d1-2ec6-11a2-9e06-fb23c1bd9694@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jvkfOLIeDQcdnJmAtQAATH5bIiHqXOMq1
Content-Type: multipart/mixed; boundary="KufagDNTvFuN888kNCvpswfCSG2h6wcww";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
 =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org
Message-ID: <bb5de699-d374-3552-b2c0-eca5db55feaa@pengutronix.de>
Subject: Re: [RFC, PATCH v2] can: add CAN interface API for fixed bitrates
References: <20170111161003.14506-1-mkl@pengutronix.de>
 <CAKT-o-dudc56=0GV0EHJWXjGAtNxavzKNq+dWSrttJ2o52_A1A@mail.gmail.com>
 <083932d1-2ec6-11a2-9e06-fb23c1bd9694@hartkopp.net>
In-Reply-To: <083932d1-2ec6-11a2-9e06-fb23c1bd9694@hartkopp.net>

--KufagDNTvFuN888kNCvpswfCSG2h6wcww
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 05:36 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 01/12/2017 10:41 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
>> Looks good to me.
>>
>> Cheers,
>> Remik
>>
>> On 11 January 2017 at 17:10, Marc Kleine-Budde <mkl@pengutronix.de> wr=
ote:
>>> Inside the driver:
>>> const u32 drvname_bitrate[] =3D { 20000, 50000, 100000 };
>>>
>>> struct drvname_priv *priv;
>>> priv =3D netdev_priv(dev);
>>>
>>> priv->bitrate_const =3D drvname_bitrate;
>>> priv->bitrate_const_cnt =3D ARRAY_SIZE(drvname_bitrate);
>>>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>> Hello,
>>>
>>> based on Remik's work. Rebased on the latest CAN termination API, str=
eamlined
>>> and add support for data_bitrate.
>>>
>>> regards,
>>> Marc
>>>
>>>  drivers/net/can/dev.c            | 83 ++++++++++++++++++++++++++++++=
++--------
>>>  include/linux/can/dev.h          |  4 ++
>>>  include/uapi/linux/can/netlink.h |  2 +
>>>  3 files changed, 73 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index 254183e5baf9..db6ad7f5d96d 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -279,8 +279,29 @@ static int can_fixup_bittiming(struct net_device=
 *dev, struct can_bittiming *bt,
>>>         return 0;
>>>  }
>>>
>>> +/* Checks the validity of predefined bitrate settings */
>>> +static int can_validate_bitrate(struct net_device *dev, struct can_b=
ittiming *bt,
>>> +                               const u32 *bitrate_const,
>>> +                               const int bitrate_const_cnt)
>>> +{
>>> +       struct can_priv *priv =3D netdev_priv(dev);
>>> +       int i;
>>> +
>>> +       for (i =3D 0; i < bitrate_const_cnt; i++) {
>>> +               if (bt->bitrate =3D=3D bitrate_const[i])
>>> +                       break;
>>> +       }
>>> +
>>> +       if (i >=3D priv->bitrate_const_cnt)
>>> +               return -EINVAL;
>>> +
>>> +       return 0;
>>> +}
>>> +
>>>  static int can_get_bittiming(struct net_device *dev, struct can_bitt=
iming *bt,
>>> -                            const struct can_bittiming_const *btc)
>>> +                            const struct can_bittiming_const *btc,
>>> +                            const u32 *bitrate_const,
>>> +                            const int bitrate_const_cnt)
>>>  {
>>>         int err;
>>>
>>> @@ -290,10 +311,13 @@ static int can_get_bittiming(struct net_device =
*dev, struct can_bittiming *bt,
>>>          * alternatively the CAN timing parameters (tq, prop_seg, etc=
=2E) are
>>>          * provided directly which are then checked and fixed up.
>>>          */
>>> -       if (!bt->tq && bt->bitrate)
>>> +       if (!bt->tq && bt->bitrate && btc)
>>>                 err =3D can_calc_bittiming(dev, bt, btc);
>>> -       else if (bt->tq && !bt->bitrate)
>>> +       else if (bt->tq && !bt->bitrate && btc)
>>>                 err =3D can_fixup_bittiming(dev, bt, btc);
>>> +       else if (!bt->tq && bt->bitrate && bitrate_const)
>>> +               err =3D can_validate_bitrate(dev, bt, bitrate_const,
>>> +                                          bitrate_const_cnt);
>>>         else
>>>                 err =3D -EINVAL;
>>>
>>> @@ -878,12 +902,12 @@ static int can_changelink(struct net_device *de=
v,
>>>                         return -EOPNOTSUPP;
>>>
>>>                 memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeo=
f(bt));
>>> -               if (priv->bittiming_const) {
>>> -                       err =3D can_get_bittiming(dev, &bt,
>>> -                                               priv->bittiming_const=
);
>>> -                       if (err)
>>> -                               return err;
>>> -               }
>>> +               err =3D can_get_bittiming(dev, &bt,
>>> +                                       priv->bittiming_const,
>>> +                                       priv->bitrate_const,
>>> +                                       priv->bitrate_const_cnt);
>>> +               if (err)
>>> +                       return err;
>>>                 memcpy(&priv->bittiming, &bt, sizeof(bt));
>>>
>>>                 if (priv->do_set_bittiming) {
>>> @@ -962,12 +986,12 @@ static int can_changelink(struct net_device *de=
v,
>>>
>>>                 memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),=

>>>                        sizeof(dbt));
>>> -               if (priv->data_bittiming_const) {
>>> -                       err =3D can_get_bittiming(dev, &dbt,
>>> -                                               priv->data_bittiming_=
const);
>>> -                       if (err)
>>> -                               return err;
>>> -               }
>>> +               err =3D can_get_bittiming(dev, &dbt,
>>> +                                       priv->data_bittiming_const,
>>> +                                       priv->data_bitrate_const,
>>> +                                       priv->data_bitrate_const_cnt)=
;
>>> +               if (err)
>>> +                       return err;
>>>                 memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
>>>
>>>                 if (priv->do_set_data_bittiming) {
>>> @@ -1029,6 +1053,12 @@ static size_t can_get_size(const struct net_de=
vice *dev)
>>>                 size +=3D nla_total_size(sizeof(*priv->termination_co=
nst) *       /* IFLA_CAN_TERMINATION_CONST */
>>>                                        priv->termination_const_cnt);
>>>         }
>>> +       if (priv->bitrate_const)                                /* IF=
LA_CAN_BITRATE_CONST */
>>> +               size +=3D nla_total_size(sizeof(*priv->bitrate_const)=
 *
>>> +                                      priv->bitrate_const_cnt);
>>> +       if (priv->data_bitrate_const)                           /* IF=
LA_CAN_DATA_BITRATE_CONST */
>>> +               size +=3D nla_total_size(sizeof(*priv->data_bitrate_c=
onst) *
>>> +                                      priv->data_bitrate_const_cnt);=

>>>
>>>         return size;
>>>  }
>>> @@ -1074,7 +1104,20 @@ static int can_fill_info(struct sk_buff *skb, =
const struct net_device *dev)
>>>               nla_put(skb, IFLA_CAN_TERMINATION_CONST,
>>>                       sizeof(*priv->termination_const) *
>>>                       priv->termination_const_cnt,
>>> -                     priv->termination_const))))
>>> +                     priv->termination_const))) ||
>>> +
>>> +           (priv->bitrate_const &&
>>> +            nla_put(skb, IFLA_CAN_BITRATE_CONST,
>>> +                    sizeof(*priv->bitrate_const) *
>>> +                    priv->bitrate_const_cnt,
>>> +                    priv->bitrate_const)) ||
>>> +
>>> +           (priv->data_bitrate_const &&
>>> +            nla_put(skb, IFLA_CAN_BITRATE_CONST,
>=20
> copy/paste?
>=20
> IFLA_CAN_DATA_BITRATE_CONST

Tnx.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--KufagDNTvFuN888kNCvpswfCSG2h6wcww--

--jvkfOLIeDQcdnJmAtQAATH5bIiHqXOMq1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh4rDkACgkQPTuqJayp
JWrAmgf/XZWW0om7Gj/ngq1QVtWGRGkelUJz80xeg7N5lXGUVCFoUkpWIYyDvURs
KgSt1Pp3yGHqJQPXkl9xa02zxZxGHFJbIlgY58NARvuNElkyBr8hcdqP24fKFDhU
Hke/cVFqNaaKl/ZaosqFxoxVdKD3sHekbBFGwq2Fm4uaE2AsSD0GsZu9H7sT546i
vqslqJTtmoktViVn+y8G5ou2zDb9PcERy48gIDIoEc+JSjmo7kKYDJ3ZvdEvTF3G
gWiHnwGhd/CFEEDQpuftvZ8TT0hePz0/DGGVnOqEPYWVhOAY623vS248RBtCudc7
lHfEhmoU5tFTX20aiOeOsuisZs4oew==
=Fk7n
-----END PGP SIGNATURE-----

--jvkfOLIeDQcdnJmAtQAATH5bIiHqXOMq1--
