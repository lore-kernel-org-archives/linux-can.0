From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: j1939: struct j1939_priv::kref
Date: Thu, 1 Jun 2017 15:14:26 +0200
Message-ID: <8dd1fbee-5488-3519-7997-c38220e4bf1a@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="XVDk3fVKLWdp8ISL7FuF5uBvGVBK5Vxvp"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:54377 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751089AbdFANOh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 1 Jun 2017 09:14:37 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XVDk3fVKLWdp8ISL7FuF5uBvGVBK5Vxvp
Content-Type: multipart/mixed; boundary="qdjanGfJxfdmeoOtswSGjNxGCl4vOTo4o";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can <linux-can@vger.kernel.org>, David Jander <david@protonic.nl>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Message-ID: <8dd1fbee-5488-3519-7997-c38220e4bf1a@pengutronix.de>
Subject: j1939: struct j1939_priv::kref

--qdjanGfJxfdmeoOtswSGjNxGCl4vOTo4o
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

while reviewing the j1939 I stumbled over the struct j1939_priv....

> struct j1939_priv {
> 	struct list_head ecus;
> 	/* local list entry in priv
> 	 * These allow irq (& softirq) context lookups on j1939 devices
> 	 * This approach (separate lists) is done as the other 2 alternatives
> 	 * are not easier or even wrong
> 	 * 1) using the pure kobject methods involves mutexes, which are not
> 	 *    allowed in irq context.
> 	 * 2) duplicating data structures would require a lot of synchronizati=
on
> 	 *    code
> 	 * usage:
> 	 */
>=20
> 	/* segments need a lock to protect the above list */
> 	rwlock_t lock;
>=20
> 	int ifindex;
> 	struct net_device *netdev;
> 	struct addr_ent {
> 		ktime_t rxtime;
> 		struct j1939_ecu *ecu;
> 		/* count users, to help transport protocol */
> 		int nusers;
> 	} ents[256];
>=20
> 	/* tasklet to process ecu address claimed events.
> 	 * These events raise in hardirq context. Signalling the event
> 	 * and scheduling this tasklet successfully moves the
> 	 * event to softirq context
> 	 */
> 	struct tasklet_struct ac_task;
>=20
> 	/* list of 256 ecu ptrs, that cache the claimed addresses.
> 	 * also protected by the above lock
> 	 * don't use directly, use j1939_ecu_set_address() instead
> 	 */
> 	struct kref kref;

=2E..and the comment above the kref make no sense to me. Is it a left ove=
r
from previous versions?

>=20
> 	/* ref counter that hold the number of active listeners.
> 	 * This number itself is protected with a mutex
> 	 */
> 	int nusers;

I want to get rid of nusers and use kref only instead.

> };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qdjanGfJxfdmeoOtswSGjNxGCl4vOTo4o--

--XVDk3fVKLWdp8ISL7FuF5uBvGVBK5Vxvp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlkwEzIACgkQHv7KIOw4
HPYQ3Af/ZnAAVJHionBYEm/oD4rs93sQIIygCwwLzN1aCpbwNpIrlxChlOH6YZJh
eo95JvSgX2QT5a6+6+7HkQHjpSsRc7Hibw7px9H2o/dP5Xo4+8BS1XAn6hFehRmh
9/hQv46xs/AzDSuy8Ff77mJN1mgGjsVs0pmBlJAKOckikCCewjWH0Ri6NJvE0gUv
9lOm10guPyvZZBqVl8GPS3LkyDP+PnXv+RRCBang4JmU9GVWtIvfD58iMDEaEtMs
3ke8D8ZcYjEeZY1hC6k9i+p5gHmY7PL1040nhMTC12olsoc33ZhbyIE0VL3QGYtV
fi9I1xH0JIa0RgrF89IBUXunUzdTjw==
=DoZ3
-----END PGP SIGNATURE-----

--XVDk3fVKLWdp8ISL7FuF5uBvGVBK5Vxvp--
