From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: add CAN interface termination API
Date: Fri, 13 Jan 2017 12:28:04 +0100
Message-ID: <3dfb74e8-fb3a-2b3e-7e0b-60ae871a1ea8@pengutronix.de>
References: <20170111152758.3578-1-mkl@pengutronix.de>
 <CAKT-o-e+h+bBU9SuDPDA8zdGT8HAr+tcXLOwziUhAEgFvgH3Pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HhsxqHfh88FhCImgbuDn7FjtjWLVqiNMs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:47781 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751419AbdAML2N (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 13 Jan 2017 06:28:13 -0500
In-Reply-To: <CAKT-o-e+h+bBU9SuDPDA8zdGT8HAr+tcXLOwziUhAEgFvgH3Pg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HhsxqHfh88FhCImgbuDn7FjtjWLVqiNMs
Content-Type: multipart/mixed; boundary="53RS9guFTAB38agFp2TsgEREdOQCIKUlt";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?=
 <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <3dfb74e8-fb3a-2b3e-7e0b-60ae871a1ea8@pengutronix.de>
Subject: Re: [PATCH] can: add CAN interface termination API
References: <20170111152758.3578-1-mkl@pengutronix.de>
 <CAKT-o-e+h+bBU9SuDPDA8zdGT8HAr+tcXLOwziUhAEgFvgH3Pg@mail.gmail.com>
In-Reply-To: <CAKT-o-e+h+bBU9SuDPDA8zdGT8HAr+tcXLOwziUhAEgFvgH3Pg@mail.gmail.com>

--53RS9guFTAB38agFp2TsgEREdOQCIKUlt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2017 09:21 AM, Ko=C5=82=C5=82=C4=85taj, Remigiusz wrote:
> Marc,
>=20
> On 11 January 2017 at 16:27, Marc Kleine-Budde <mkl@pengutronix.de> wro=
te:
>>
>> From: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> This patch adds a netlink interface to configure the CAN bus terminati=
on of
>> CAN interfaces.
>>
>> Inside the driver an array of supported termination values is defined:=

>>
>> const u16 drvname_termination[] =3D { 60, 120, CAN_TERMINATION_DISABLE=
D };
>>
>> struct drvname_priv *priv;
>> priv =3D netdev_priv(dev);
>>
>> priv->termination_const =3D &drvname_termination;
>> priv->termination_const_cnt =3D ARRAY_SIZE(drvname_termination);
>> priv->termination =3D CAN_TERMINATION_DISABLED;
>>
>> And the funtion to set the value has to be defined:
>>
>> priv->do_set_termination =3D drvname_set_termination;
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>> Hello,
>>
>> picking up Oliver's work.
>>
>> Changes since v3:
>> - can_changelink: use "const".
>> - register_candev: add consistency check for termination_const and ter=
mination_const_cnt
>> - can_get_size & can_fill_info: remove check for termination_const_cnt=

>> - can_get_size: reorder to match IFLA_CAN_ enum.
>> - can_get_size & can_fill_info: convert sizeof(u16) to use appropriate=
 member of struct can_priv.
>> - can_fill_info: use || to chain multiple nla_put.
>>
>>  drivers/net/can/dev.c            | 48 +++++++++++++++++++++++++++++++=
++++++++-
>>  include/linux/can/dev.h          |  4 ++++
>>  include/uapi/linux/can/netlink.h |  5 +++++
>>  3 files changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>> index c240cd9f823b..254183e5baf9 100644
>> --- a/drivers/net/can/dev.c
>> +++ b/drivers/net/can/dev.c
>> @@ -978,6 +978,30 @@ static int can_changelink(struct net_device *dev,=

>>                 }
>>         }
>>
>> +       if (data[IFLA_CAN_TERMINATION]) {
>> +               const u16 termval =3D nla_get_u16(data[IFLA_CAN_TERMIN=
ATION]);
>> +               const int num_term =3D priv->termination_const_cnt;
>> +               int i;
>> +
>> +               if (!priv->do_set_termination)
>> +                       return -EOPNOTSUPP;
>> +
>> +               /* check whether given value is supported by the inter=
face */
>> +               for (i =3D 0; i < num_term; i++) {
>> +                       if (termval =3D=3D priv->termination_const[i])=

>> +                               break;
>> +               }
>> +               if (i >=3D num_term)
>> +                       return -EINVAL;
>> +
>> +               /* Finally, set the termination value */
>> +               err =3D priv->do_set_termination(dev, termval);
>> +               if (err)
>> +                       return err;
>> +
>> +               priv->termination =3D termval;
>> +       }
>> +
>>         return 0;
>>  }
>>
>> @@ -1000,6 +1024,11 @@ static size_t can_get_size(const struct net_dev=
ice *dev)
>>                 size +=3D nla_total_size(sizeof(struct can_bittiming))=
;
>>         if (priv->data_bittiming_const)                         /* IFL=
A_CAN_DATA_BITTIMING_CONST */
>>                 size +=3D nla_total_size(sizeof(struct can_bittiming_c=
onst));
>> +       if (priv->termination_const) {
>> +               size +=3D nla_total_size(sizeof(priv->termination));  =
            /* IFLA_CAN_TERMINATION */
>> +               size +=3D nla_total_size(sizeof(*priv->termination_con=
st) *       /* IFLA_CAN_TERMINATION_CONST */
>> +                                      priv->termination_const_cnt);
>> +       }
>>
>>         return size;
>>  }
>> @@ -1038,7 +1067,15 @@ static int can_fill_info(struct sk_buff *skb, c=
onst struct net_device *dev)
>>             (priv->data_bittiming_const &&
>>              nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>>                      sizeof(*priv->data_bittiming_const),
>> -                    priv->data_bittiming_const)))
>> +                    priv->data_bittiming_const)) ||
>> +
>> +           (priv->termination_const &&
>> +            (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination=
) ||
>> +             nla_put(skb, IFLA_CAN_TERMINATION_CONST,
>> +                     sizeof(*priv->termination_const) *
>> +                     priv->termination_const_cnt,
>> +                     priv->termination_const))))
>> +
>>                 return -EMSGSIZE;
>>
>>         return 0;
>> @@ -1093,6 +1130,15 @@ static struct rtnl_link_ops can_link_ops __read=
_mostly =3D {
>>   */
>>  int register_candev(struct net_device *dev)
>>  {
>> +       struct can_priv *priv =3D netdev_priv(dev);
>> +
>> +       /* Ensure termination_cost and termination_const_cnt
>> +        * consistency. Both must be either set or unset.
>> +        */
>> +       if ((priv->termination_const && priv->termination_const_cnt <=3D=
 0) ||
>> +           (!priv->termination_const && priv->termination_const_cnt !=
=3D 0))
>> +               return -EINVAL;
>=20
> Current check allows to configure do_set_termination callback with
> termination_const =3D NULL and termination_const_cnt =3D 0.

Right...should check that, too.

> With such config every subsequent can_changelink call with
> IFLA_CAN_TERMINATION will fail (i.e. will return -EINVAL). Maybe we
> could prevent such settings here during device registration?>
> e.g. by modifying check to:
>=20
>        if ((priv->termination_const && priv->termination_const_cnt <=3D=
 0) ||
>           (!priv->termination_const && priv->termination_const_cnt !=3D=
 0) ||
>           (priv->do_set_termination && !priv->termination_const))
>=20

I've converted the _cnt to "unsigned int" and reduced the check to:

> 	/* Ensure termination_const, termination_const_cnt and
> 	 * do_set_termination consistency. All must be either set or
> 	 * unset.
> 	 */
> 	if ((!priv->termination_const !=3D !priv->termination_const_cnt) ||
> 	    (!priv->termination_const !=3D !priv->do_set_termination))
> 		return -EINVAL;

All must be either set or unset.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--53RS9guFTAB38agFp2TsgEREdOQCIKUlt--

--HhsxqHfh88FhCImgbuDn7FjtjWLVqiNMs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh4ucQACgkQPTuqJayp
JWrljgf/S9hwIzchfGfEmS/ajjs04YI3MHN/TLHFYPfYvw30NLUoWsfVtw3x7Id0
iPztsrY2kpd8m3aaA/n1jGQc9flw3ehgqbWwyQxVBIU3h4OgJZXInXxhZrKVi1GF
5ENp4bgPdGf2f1LxhHTHdU7IqLOvsT3TE4UxC/lrSU1GJ14Ft2dcloNt2X5hi72c
X19f5hjlQj5xYVmZxNDtPJskNJzgK627PkRPOwkp+GQ9ux0ymiDSd9+1u1a7jx40
EzHKL65eDdkq0ZFgM+SZ7+ISFEyzkamCsi97PHbW7wsGTyfHjt60TG13EraPl/og
7mtqcdMTo73IwE2SJe/MCGjob3C3cg==
=J933
-----END PGP SIGNATURE-----

--HhsxqHfh88FhCImgbuDn7FjtjWLVqiNMs--
