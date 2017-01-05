From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
Date: Thu, 5 Jan 2017 17:23:18 +0100
Message-ID: <b65830e9-8341-7089-297b-617dcbb773e3@pengutronix.de>
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
 <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
 <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
 <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="u3S8HBGx65PCjN0pq7iAJsCxD8hCOknJj"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44767 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966150AbdAEQmn (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 11:42:43 -0500
In-Reply-To: <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u3S8HBGx65PCjN0pq7iAJsCxD8hCOknJj
Content-Type: multipart/mixed; boundary="lUf2qnLad7ONjd23M6IlaB0c4GJPAhqu4";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephane Grosjean <s.grosjean@peak-system.com>,
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>
Message-ID: <b65830e9-8341-7089-297b-617dcbb773e3@pengutronix.de>
Subject: Re: [PATCH 4/4] can: peak: add support for PEAK PCAN-PCIe FD CAN-FD
 boards
References: <1481207924-28977-1-git-send-email-s.grosjean@peak-system.com>
 <1481207924-28977-5-git-send-email-s.grosjean@peak-system.com>
 <4b5d6e27-0680-81b8-66f3-f5ff219eab45@pengutronix.de>
 <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>
In-Reply-To: <421a8a25-b808-1771-63dc-df3cb7431f9b@peak-system.com>

--lUf2qnLad7ONjd23M6IlaB0c4GJPAhqu4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 02:52 PM, Stephane Grosjean wrote:
>>> +
>>> +	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
>>> +		msg_flags |=3D PUCAN_MSG_LOOPED_BACK;
>>> +
>>> +	msg->flags =3D cpu_to_le16(msg_flags);
>>> +	msg->channel_dlc =3D PUCAN_MSG_CHANNEL_DLC(priv->index, can_dlc);
>>> +	memcpy(msg->d, cf->data, cf->len);
>>> +
>>> +	priv->write_tx_msg(priv);
>>> +
>>> +	stats->tx_bytes +=3D can_dlc;
>>> +	stats->tx_packets++;
>>> +
>>> +	/* put skb in rx queue as echo */
>>> +	netif_rx(skb);
>> Please wait until you get a tx-complete interrupt until you echo the s=
kb.

> No "tx-complete" IRQ is provided by the hw but an "LNK record=20
> encountered by the reader" interrupt only: this LNK record is put at th=
e=20
> end of a 2K DMA page by the writer, to link this page to the next one. =
I=20
> don't imagine saving the N * CAN msgs the page might contain, in some=20
> temporary memory until getting (sometimes in the future) this kind of=20
> IRQ, for, finally echoing all of these ones in a row, do you?

Hmmm. Okay. Then don't set IFF_ECHO and the framework will do the rest
for you.

>>> +	if (sub_sys_id >=3D 0x0012)
>>> +		can_count =3D 4;
>>> +	else if (sub_sys_id >=3D 0x0010)
>>> +		can_count =3D 3;
>>> +	else if (sub_sys_id >=3D 0x0004)
>>> +		can_count =3D 2;
>>> +	else
>>> +		can_count =3D 1;
>>> +
>>> +	/* allocate board structure object */
>>> +	pciefd =3D kmalloc(sizeof(*pciefd) + sizeof(*pciefd->can) * can_cou=
nt,
>>> +			 GFP_KERNEL);
>> devm_kzalloc?
>>
>> sizeof(*pciefd->can), you only want to have the memory to hold the
>> pointer to can_count of struct pciefd_can, right? But you are allocati=
ng
>> the actual memory for can_count of struct pciefd_can.

> Nope: I currently allocate room for 'can-count' items, of=20
> sizeof(*pciefd->can) bytes each, while sizeof(*pciefd->can) =3D=20
> sizeof(pciefd->can[0]) =3D sizeof(struct pciefd_can *) (IMHO)

Doh! Yes, your're right.

> /* PEAK-PCIe FD board object */
> struct pciefd_board {
>          void __iomem *reg_base;
>          struct pci_dev *pci_dev;
>          spinlock_t cmd_lock;            /* 64-bits cmds must be atomic=
 */
>          struct pciefd_can *can[0];      /* array of network devices */=

> };

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--lUf2qnLad7ONjd23M6IlaB0c4GJPAhqu4--

--u3S8HBGx65PCjN0pq7iAJsCxD8hCOknJj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlhucvcACgkQPTuqJayp
JWppOQf/VX5Y+jlOVxMgq93uFq8DTR3XdqfYWa+Ak7qdipKctOLoiVBUv04nWz7S
Ian+uSfse+ephIZwYIOhhbPqxR4MchnBAhrliW0OuoXAvIwFerYX38YigZjOd0QQ
+BGPgEGdN7cOEKySeKAV/HX3YIjwKguUXA1yEyCa7XMgg0LbVKkNUOOBfod9YEoU
DZ6bi9iLWVWtFNT4gwb/eGAgi4MRG1yti7jIjIXQ2ifJ7d3H/UjCQh+pHhfhQpv8
nCopkj/1DaZaUjtBAXejNzOq3Chh/QHfjeu/wC6nHoujSefIyK64sKOKjuT929Dh
IFw8dP0qj1yKUfM97La0e3UouyzXrQ==
=i99Y
-----END PGP SIGNATURE-----

--u3S8HBGx65PCjN0pq7iAJsCxD8hCOknJj--
