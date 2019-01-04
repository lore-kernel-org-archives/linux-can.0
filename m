From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
Date: Fri, 4 Jan 2019 15:16:11 +0100
Message-ID: <2fedd775-fdf6-0008-023a-3db578486e4f@pengutronix.de>
References: <20190104091353.2438-1-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="KVUzG4Tx8wtUN0VXGWJkbgLNSo2JbUvM4"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190104091353.2438-1-socketcan@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net, netdev@vger.kernel.org
Cc: ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz, linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KVUzG4Tx8wtUN0VXGWJkbgLNSo2JbUvM4
Content-Type: multipart/mixed; boundary="dWtn2mYYknchDfPZF44vnhzikJ9xv9WtY";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, davem@davemloft.net,
 netdev@vger.kernel.org
Cc: ieatmuttonchuan@gmail.com, meissner@suse.de, mkubecek@suse.cz,
 linux-can@vger.kernel.org, linux-stable <stable@vger.kernel.org>
Message-ID: <2fedd775-fdf6-0008-023a-3db578486e4f@pengutronix.de>
Subject: Re: [PATCH] can: gw: ensure DLC boundaries after CAN frame
 modification
References: <20190104091353.2438-1-socketcan@hartkopp.net>
In-Reply-To: <20190104091353.2438-1-socketcan@hartkopp.net>

--dWtn2mYYknchDfPZF44vnhzikJ9xv9WtY
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 1/4/19 10:13 AM, Oliver Hartkopp wrote:
> Muyu Yu provided a POC where user root with CAP_NET_ADMIN can create a =
CAN
> frame modification rule that makes the data length code a higher value =
than
> the available CAN frame data size. In combination with a configured che=
cksum
> calculation where the result is stored relatively to the end of the dat=
a
> (e.g. cgw_csum_xor_rel) the tail of the skb (e.g. frag_list pointer in
> skb_shared_info) can be rewritten which finally can cause a system cras=
h.
>=20
> Michael Kubecek suggested to drop frames that have a DLC exceeding the
> available space after the modification process and provided a patch tha=
t can
> handle CAN FD frames too. Within this patch we also limit the length fo=
r the
> checksum calculations to the maximum of Classic CAN data length (8).
>=20
> CAN frames that are dropped by these additional checks are counted with=
 the
> CGW_DELETED counter which indicates misconfigurations in can-gw rules.
>=20
> This fixes CVE-2019-3701.
>=20
> Reported-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Reported-by: Marcus Meissner <meissner@suse.de>
> Suggested-by: Michal Kubecek <mkubecek@suse.cz>
> Tested-by: Muyu Yu <ieatmuttonchuan@gmail.com>
> Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> Cc: linux-stable <stable@vger.kernel.org> # >=3D v3.2
> ---
>  net/can/gw.c | 36 +++++++++++++++++++++++++++++++-----
>  1 file changed, 31 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/can/gw.c b/net/can/gw.c
> index faa3da88a127..180c389af5b1 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -416,13 +416,31 @@ static void can_can_gw_rcv(struct sk_buff *skb, v=
oid *data)
>  	while (modidx < MAX_MODFUNCTIONS && gwj->mod.modfunc[modidx])
>  		(*gwj->mod.modfunc[modidx++])(cf, &gwj->mod);
> =20
> -	/* check for checksum updates when the CAN frame has been modified */=

> +	/* Has the CAN frame been modified? */
>  	if (modidx) {
> -		if (gwj->mod.csumfunc.crc8)
> -			(*gwj->mod.csumfunc.crc8)(cf, &gwj->mod.csum.crc8);
> +		/* get available space for the processed CAN frame type */
> +		int max_len =3D nskb->len - offsetof(struct can_frame, data);
> =20
> -		if (gwj->mod.csumfunc.xor)
> -			(*gwj->mod.csumfunc.xor)(cf, &gwj->mod.csum.xor);
> +		/* dlc may have changed, make sure it fits to the CAN frame */
> +		if (cf->can_dlc > max_len)
> +			goto out_delete;
> +
> +		/* check for checksum updates in classic CAN length only */
> +		if (gwj->mod.csumfunc.crc8) {
> +			if (cf->can_dlc > 8)
> +				goto out_delete;
> +			else
> +				(*gwj->mod.csumfunc.crc8)
> +					(cf, &gwj->mod.csum.crc8);

What about removing the else, then we can keep this in one line.
> +		}
> +
> +		if (gwj->mod.csumfunc.xor) {
> +			if (cf->can_dlc > 8)
> +				goto out_delete;
> +			else
> +				(*gwj->mod.csumfunc.xor)
> +					(cf, &gwj->mod.csum.xor);

same here

> +		}
>  	}
> =20
>  	/* clear the skb timestamp if not configured the other way */
> @@ -434,6 +452,14 @@ static void can_can_gw_rcv(struct sk_buff *skb, vo=
id *data)
>  		gwj->dropped_frames++;
>  	else
>  		gwj->handled_frames++;
> +
> +	return;
> +
> +out_delete:
> +	/* delete frame due to misconfiguration */
> +	gwj->deleted_frames++;
> +	kfree_skb(nskb);
> +	return;
>  }
> =20
>  static inline int cgw_register_filter(struct net *net, struct cgw_job =
*gwj)
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--dWtn2mYYknchDfPZF44vnhzikJ9xv9WtY--

--KVUzG4Tx8wtUN0VXGWJkbgLNSo2JbUvM4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENrCndlB/VnAEWuH5k9IU1zQoZfEFAlwvaqsACgkQk9IU1zQo
ZfE9IAf/ba6jQe7CGjxmBy/cyayUU4AOSckBo3ToYFMkxWi+YlLJ1NeO+7humtqc
4MGEzmdDUIp73gpKXz4QRoY5ABRNslMRX5Qj12flPjew5+leVwD/XfhFJbWhBAHQ
mPg1eiK8Uu7F3fmhQWHcrdZmL298+jf5CeE58mg7NqpeBhTYeLduINBT0hc4NYRB
2H/mv+iPXqacHX5gXsQLLRO/uE1IlYXiYFVPYU8Ik1j8Hn30l2EI8MUBixDTAsIG
UdhBi/yF4LRhIfjLaZuhuaulWi8XnqM1Tc4YA3+3IiGT4ff5T9MsBbkP0MbpagQ8
rYYNSRdzl1XWSNVALIuiZ4+zFADKfQ==
=fkGB
-----END PGP SIGNATURE-----

--KVUzG4Tx8wtUN0VXGWJkbgLNSo2JbUvM4--
