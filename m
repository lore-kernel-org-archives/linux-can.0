From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
Date: Mon, 9 Dec 2019 17:07:31 +0100
Message-ID: <547fd63f-6d79-2ce7-3bd8-29949260189d@pengutronix.de>
References: <20191207183418.28868-1-socketcan@hartkopp.net>
 <cc102c3b-d9d3-6447-7581-a36795259cc2@pengutronix.de>
 <2b997c05-fcef-e067-2771-8e07e35dfadd@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="JTLSR7X2EXpraVkHslfGWCRuJ8N2IsEt1"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <2b997c05-fcef-e067-2771-8e07e35dfadd@hartkopp.net>
Sender: netdev-owner@vger.kernel.org
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org, dvyukov@google.com
Cc: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com, glider@google.com, syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org, o.rempel@pengutronix.de, eric.dumazet@gmail.com
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JTLSR7X2EXpraVkHslfGWCRuJ8N2IsEt1
Content-Type: multipart/mixed; boundary="8O8qOyFE32kqnxD6fDG4q4wTtjqEWxrhU";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org,
 dvyukov@google.com
Cc: syzbot+b02ff0707a97e4e79ebb@syzkaller.appspotmail.com, glider@google.com,
 syzkaller-bugs@googlegroups.com, netdev@vger.kernel.org,
 o.rempel@pengutronix.de, eric.dumazet@gmail.com
Message-ID: <547fd63f-6d79-2ce7-3bd8-29949260189d@pengutronix.de>
Subject: Re: [PATCH] can: ensure an initialized headroom in outgoing CAN
 sk_buffs
References: <20191207183418.28868-1-socketcan@hartkopp.net>
 <cc102c3b-d9d3-6447-7581-a36795259cc2@pengutronix.de>
 <2b997c05-fcef-e067-2771-8e07e35dfadd@hartkopp.net>
In-Reply-To: <2b997c05-fcef-e067-2771-8e07e35dfadd@hartkopp.net>

--8O8qOyFE32kqnxD6fDG4q4wTtjqEWxrhU
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

On 12/8/19 12:34 PM, Oliver Hartkopp wrote:
>=20
>=20
> On 08/12/2019 11.48, Marc Kleine-Budde wrote:
>> On 12/7/19 7:34 PM, Oliver Hartkopp wrote:
>>> KMSAN sysbot detected a read access to an untinitialized value in the=
 headroom
>>> of an outgoing CAN related sk_buff. When using CAN sockets this area =
is filled
>>> appropriately - but when using a packet socket this initialization is=
 missing.
>=20
>=20
>>> +/* Check for outgoing skbs that have not been created by the CAN sub=
system */
>>> +static inline bool can_check_skb_headroom(struct net_device *dev,
>>> +					  struct sk_buff *skb)
>>
>> Do we want to have such a big function as a static inline?
>>
>=20
> No. Usually not. can_dropped_invalid_skb() has the same problem IMO.
>=20
> This additional inline function approach was the only way to ensure=20
> simple backwards portability for stable kernels.

A "normal" function called from the can_dropped_invalid_skb() works aswel=
l.

> I would suggest to clean this up once this patch went into mainline.
>=20
>>> +{
>>> +	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine =
*/
>>> +	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
>>> +		return true;
>>> +
>>> +	/* af_packet does not apply CAN skb specific settings */
>>> +	if (skb->ip_summed =3D=3D CHECKSUM_NONE) {
>>
>> Is it possible to set the ip_summed via the packet socket or is it
>> always 0 (=3D=3D CHECKSUM_NONE)?
>=20
> af_packet only reads ip_summed in the receive path. It is not set when =

> creating the outgoing skb where the struct skb is mainly zero'ed.
>=20
>>
>>> +
>>
>> Please remove that empty line.
>>
>=20
> ok.
>=20
>>> +		/* init headroom */
>>> +		can_skb_prv(skb)->ifindex =3D dev->ifindex;
>>> +		can_skb_prv(skb)->skbcnt =3D 0;
>>> +
>>> +		skb->ip_summed =3D CHECKSUM_UNNECESSARY;
>>> +
>>> +		/* preform proper loopback on capable devices */
>>> +		if (dev->flags & IFF_ECHO)
>>> +			skb->pkt_type =3D PACKET_LOOPBACK;
>>> +		else
>>> +			skb->pkt_type =3D PACKET_HOST;
>>> +
>>> +		skb_reset_mac_header(skb);
>>> +		skb_reset_network_header(skb);
>>> +		skb_reset_transport_header(skb);
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>>   /* Drop a given socketbuffer if it does not contain a valid CAN fra=
me. */
>>>   static inline bool can_dropped_invalid_skb(struct net_device *dev,
>>>   					  struct sk_buff *skb)
>>> @@ -108,6 +140,9 @@ static inline bool can_dropped_invalid_skb(struct=
 net_device *dev,
>>>   	} else
>>>   		goto inval_skb;
>>>  =20
>>> +	if (can_check_skb_headroom(dev, skb))
>>
>> Can you rename the function, so that it's clear that returning false
>> means it's an invalid skb?
>>
>=20
> Returning 'false' is *good* like in can_dropped_invalid_skb(). What=20
> naming would you suggest?

Something like: can_skb_headroom_valid().

See v2 I just sent around.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |


--8O8qOyFE32kqnxD6fDG4q4wTtjqEWxrhU--

--JTLSR7X2EXpraVkHslfGWCRuJ8N2IsEt1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3ucUMACgkQWsYho5Hk
nSDeeAf+MS5yzMPcqPLMd6dYecASeaBLZVeSpqnA6NHz23POI7ow6JTHk0iGqsLd
2LD27kHPRoW7Xa+1oZJ3sADXamDlbw1Q7TBDrC6pQkhGDwmFPu9fQHr/slHVt2Yk
r6IO2O4+mS8gy33EjwGxZo72s9Pv5RA/8fwPiBnzKtlwOVyvH+uwTa5Gnm69MNmQ
SMt6nqcgnrm97PBqla0hjn0eJe6zPIdU3K6q19oe4qxhJDNu6y8cJLdNJdiYo9Qt
WcF19RrfpkV0O3XlGytZX6ZTBItXkXhmbj9pjYGM5iiCkhqnQbcbrU+CR+0vRY1a
lBXvPO9L7sHkg1ltlS+vx70u1+1heQ==
=bJcj
-----END PGP SIGNATURE-----

--JTLSR7X2EXpraVkHslfGWCRuJ8N2IsEt1--
