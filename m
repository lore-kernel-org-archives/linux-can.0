From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: peak_canfd: fix uninitialized symbol warnings
Date: Thu, 18 May 2017 10:21:36 +0200
Message-ID: <7c1f58dc-a1f6-6c82-5b61-ba2944ea8f50@pengutronix.de>
References: <1493800504-17529-1-git-send-email-s.grosjean@peak-system.com>
 <1dd51305-2399-cce0-517c-a3c17a027577@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="qus351xg1W6RS3ip3L8VgDSo7HdWLJErv"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:60471 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753168AbdERIVo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 18 May 2017 04:21:44 -0400
In-Reply-To: <1dd51305-2399-cce0-517c-a3c17a027577@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qus351xg1W6RS3ip3L8VgDSo7HdWLJErv
Content-Type: multipart/mixed; boundary="VRlACe3LQpxh97mAnQLWFOW1LE9qcwtsW";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <7c1f58dc-a1f6-6c82-5b61-ba2944ea8f50@pengutronix.de>
Subject: Re: [PATCH] can: peak_canfd: fix uninitialized symbol warnings
References: <1493800504-17529-1-git-send-email-s.grosjean@peak-system.com>
 <1dd51305-2399-cce0-517c-a3c17a027577@peak-system.com>
In-Reply-To: <1dd51305-2399-cce0-517c-a3c17a027577@peak-system.com>

--VRlACe3LQpxh97mAnQLWFOW1LE9qcwtsW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/16/2017 12:07 PM, Stephane Grosjean wrote:
> Hello Oliver,
>=20
> Has this patch been pushed in Dave Miller's net-next tree please?
>=20
> Best regards,
>=20
> Stephane
>=20
>=20
> Le 03/05/2017 =C3=A0 10:35, Stephane Grosjean a =C3=A9crit :
>> This patch fixes two uninitialized symbol warnings in the new code add=
ing
>> support of the PEAK-System PCAN-PCI Express FD boards, in the socket-C=
AN
>> network protocol family.
>>
>> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
>> ---
>>   drivers/net/can/peak_canfd/peak_canfd.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can=
/peak_canfd/peak_canfd.c
>> index 0d57be5..912bd81 100644
>> --- a/drivers/net/can/peak_canfd/peak_canfd.c
>> +++ b/drivers/net/can/peak_canfd/peak_canfd.c
>> @@ -399,8 +399,9 @@ static int pucan_handle_status(struct peak_canfd_p=
riv *priv,
>>   	} else if (priv->can.state !=3D CAN_STATE_ERROR_ACTIVE) {
>>   		/* back to ERROR_ACTIVE */
>>   		netdev_dbg(ndev, "Error active status\n");
>> -		can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
>> -				 CAN_STATE_ERROR_ACTIVE);
>> +		if (skb)
>> +			can_change_state(ndev, cf, CAN_STATE_ERROR_ACTIVE,
>> +					 CAN_STATE_ERROR_ACTIVE);

Looking at this again...In case of a OOM situation, where skb is NULL,
skipping the can_change_state() will not update the state of the candev,
see:

http://elixir.free-electrons.com/linux/latest/source/drivers/net/can/dev.=
c#L378

What about making can_change_state() safe to be called with cf=3DNULL?

> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
> index 611d16a7061d..ae4ed03dc642 100644
> --- a/drivers/net/can/dev.c
> +++ b/drivers/net/can/dev.c
> @@ -391,6 +391,9 @@ void can_change_state(struct net_device *dev, struc=
t can_frame *cf,
>         can_update_state_error_stats(dev, new_state);
>         priv->state =3D new_state;
> =20
> +       if (!cf)
> +               return;
> +
>         if (unlikely(new_state =3D=3D CAN_STATE_BUS_OFF)) {
>                 cf->can_id |=3D CAN_ERR_BUSOFF;
>                 return;

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--VRlACe3LQpxh97mAnQLWFOW1LE9qcwtsW--

--qus351xg1W6RS3ip3L8VgDSo7HdWLJErv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlkdWZAACgkQHv7KIOw4
HPYIWQgApj0H5UFBtJhd6K1JC/KObqQqXxW1vd1F7v2y20Vc6ZbOyN/c7liSLeO3
NYPcHFLRxau2JCZL52wOgVLaFK/YyDyfN1Ny6Il7ap/GnrR+u0tL9mO24wFMN5CK
1RvO0u8Y9unshxqzg4Q3yL8ylgTU+w3oQvX4SJHQ/ondqMqBkqypqPozkNmGFpoM
1tySl4uPU/N43wN7jrAuJHu6nPYcqxF9exAJdXJTpjfisLu6n0CM+U11GfRvG+TU
EHfVZgbgf/hvLiajYcEMrawU77/2SNbqSuMf2MJLqATNpSnB6Qe5R/jo4ghRU9wX
35qd5SdxCtPipIgWI4B7kYx0W/JhsA==
=J7th
-----END PGP SIGNATURE-----

--qus351xg1W6RS3ip3L8VgDSo7HdWLJErv--
