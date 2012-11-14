From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v8] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 14 Nov 2012 12:22:50 +0100
Message-ID: <50A37F0A.7050204@pengutronix.de>
References: <509C47CB.8060701@pengutronix.de> <1352732256-12712-1-git-send-email-andreas@gaisler.com> <50A2B88A.3040609@pengutronix.de> <50A34D49.2070908@gaisler.com> <50A359A1.30700@pengutronix.de> <50A37A5B.8060808@gaisler.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFA7BA2113CB58CD278045ACB"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41788 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161052Ab2KNLXE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 14 Nov 2012 06:23:04 -0500
In-Reply-To: <50A37A5B.8060808@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, software@gaisler.com, Wolfgang Grandegger <wg@grandegger.com>, devicetree-discuss@lists.ozlabs.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFA7BA2113CB58CD278045ACB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/14/2012 12:02 PM, Andreas Larsson wrote:
> On 2012-11-14 09:43, Marc Kleine-Budde wrote:
>> Handle incoming events (rx or tx-complete) until:
>> a) number of handled events =3D=3D budget
>> or
>> b) no more events pending.
>>
>>     while (work_done < budget && interrupts_pending()) {
>>         work_done +=3D handle_rx(budget - work_done);
>>         work_done +=3D handle_tx(budget - work_done);
>>     }
>=20
> That could starve handle_tx completely though under high rx pressure,
> but I can prevent that by making sure that half of the budget is held
> back in the first call to handle_rx.

What about making the budget big enough to handle both rx and tx in one
napi call. Have a look at the marvell driver [1] for inspiration.

[1]
http://lxr.free-electrons.com/source/drivers/net/ethernet/marvell/mv643xx=
_eth.c#L2140

>=20
>> Then, if you have handled less events then budget:
>> 1) call napi_complete()
>> then
>> 2) enable interrupts.
>>
>>     if (work_done < budget) {
>>         napi_complete();
>>         enable_interrupts();
>>     }
>>
>> Then, return number of handled events:
>>
>>     return work_done;
>=20
> Any additional remarks on the following implementation of the poll
> function?
>=20
> static int grcan_poll(struct napi_struct *napi, int budget)
> {
>     struct grcan_priv *priv =3D container_of(napi, struct grcan_priv, n=
api);
>     struct net_device *dev =3D priv->dev;
>     struct grcan_registers __iomem *regs =3D priv->regs;
>     unsigned long flags;
>     int work_done =3D 0;
>     int reserved =3D budget / 2;
>=20
>     while (work_done < budget) {
>         int old_work_done =3D work_done;
>=20
>         /* Prevent grcan_transmit_catch_up from starving by reserving
>          * part of the budget in the first iteration when calling
>          * grcan_receive.
>          */
>         work_done +=3D grcan_receive(dev, budget - reserved - work_done=
);
>         reserved =3D 0;
>=20
>         /* Catch up echo skb according to same budget, as
>          * grcan_transmit_catch_up can trigger echo frames being
>          * received.
>          */
>         work_done +=3D grcan_transmit_catch_up(dev, budget - work_done)=
;
>=20
>         /* Break out if nothing was done */
>         if (work_done =3D=3D old_work_done)
>             break;
>     }
>=20
>     if (work_done < budget) {
>         napi_complete(napi);
>=20
>         /* Guarantee no interference with a running reset that otherwis=
e
>          * could turn off interrupts.
>          */
>         spin_lock_irqsave(&priv->lock, flags);
>=20
>         /* Enable tx and rx interrupts again. No need to check
>          * priv->closing as napi_disable in grcan_close is waiting for
>          * scheduled napi calls to finish.
>          */
>         grcan_set_bits(&regs->imr, GRCAN_IRQ_TX | GRCAN_IRQ_RX);
>=20
>         spin_unlock_irqrestore(&priv->lock, flags);
>     }
>=20
>     return work_done;
> }
>=20
>=20
> Cheers,
> Andreas
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigFA7BA2113CB58CD278045ACB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCjfw0ACgkQjTAFq1RaXHNKtwCdEv8Qc8ai5m+lOR9ORusxCZCb
1zIAoJmVztQ0zmSRjoNbq0dYFzn0HhlB
=kpvE
-----END PGP SIGNATURE-----

--------------enigFA7BA2113CB58CD278045ACB--
