From: Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net 0/4] support multipacket broadcast message
Date: Thu, 6 Aug 2020 18:10:27 +0200
Message-ID: <20200806161027.py5ged3a23xpmxgi@pengutronix.de>
References: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q2ffmggcds5tcngt"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgHFQfT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 Aug 2020 12:35:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8EA8C00216E
        for <linux-can@vger.kernel.org>; Thu,  6 Aug 2020 09:10:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Zhang Changzhong <zhangchangzhong@huawei.com>
Cc: robin@protonic.nl, linux@rempel-privat.de, kernel@pengutronix.de, socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org


--q2ffmggcds5tcngt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Thank you for your patches! Currently I'm busy, but I'll take a look at it =
as
soon possible.

btw. can you tell me about more of your use case/work. I would like to
have some feedback about this stack. You can write a personal message,
if it is not for public.

On Wed, Aug 05, 2020 at 11:50:21AM +0800, Zhang Changzhong wrote:
> Zhang Changzhong (4):
>   can: j1939: fix support for multipacket broadcast message
>   can: j1939: cancel rxtimer on multipacket broadcast session complete
>   can: j1939: abort multipacket broadcast session when timeout occurs
>   can: j1939: add rxtimer for multipacket broadcast session
>=20
>  net/can/j1939/transport.c | 48 +++++++++++++++++++++++++++++++++++------=
------
>  1 file changed, 36 insertions(+), 12 deletions(-)

Regards,
Oleksij

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--q2ffmggcds5tcngt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8sK24ACgkQ4omh9DUa
UbNKXw//YcVYtmARpdPi2H/KsMzVUNKAtJAJv/VLjfu4gMt7LKyUfwSAoTNQMgBF
rY5RMh3hoRlSY0lZnuGf+L1IRdfioOOzN1ljiUHW49t2oJdbE3KvOQjAHRd7HkdD
8THLbi2QZtP6bl6VtJP4kX6dUV1Y9mkQNlAClA24WbntnHJ3UmTE9200ZyAFf1zQ
bmo7j/TtQCcYZla4rewSh8/nwEySFkMV0+9afm2ihD9M6Vqly9nCGx8LKbbZJXHt
yAW4N82ZZcLmEz7tDf/kUemY5TVogSCZc8XxzZb8iaO+vlhdkpZpa/+WzHR78t4A
2wHHB8jLq5M8te3DzEZ0e+lnGE7nLOeTB8Xk0TAifArMkj+8JLTeFuopuvYaNGQh
L5BSG8iml24+WndixVtA7R4Fax4lvnUCgBTni3SJiwz55dBzKTOB/ZmJcyshMPKG
91bP/sUZ9nGROlWVw+Ehhi8rJSZAKhG1qdBkfxmxQCVxK4TS7AsuHMUOwHp3jVMb
1dMlDZ30AjTf9ITcFsLW0stGAUjJQJ/TR2vqCdn/ubTPzV7yAOFxCPAyz0dIx79w
0bPnOmapDKSYViCGxyJ0oSmDqpm1GjWtKnw0gueQLprQ1ObMJyN4R5Io0kdJ0dGS
4WBfpecsE9CN0fuAwBAt/nKCOUPWSPN6r3+lbQWYOa8PQonF6Cg=
=IVdX
-----END PGP SIGNATURE-----

--q2ffmggcds5tcngt--
