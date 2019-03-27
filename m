From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] net: sch_generic: fq_codel vs pfifo_fast
Date: Wed, 27 Mar 2019 20:24:13 +0100
Message-ID: <0edf15df-b607-70f7-5fe8-2860eb663a53@pengutronix.de>
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327113059.6b1224ab@shemminger-XPS-13-9360>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="B08wmT3aOsbSbdXvTtADrwYlMLJ2ufiSo"
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190327113059.6b1224ab@shemminger-XPS-13-9360>
Sender: netdev-owner@vger.kernel.org
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>, kernel@pengutronix.de, Cong Wang <xiyou.wangcong@gmail.com>, linux-can@vger.kernel.org, davem@davemloft.net
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B08wmT3aOsbSbdXvTtADrwYlMLJ2ufiSo
Content-Type: multipart/mixed; boundary="holF2ua9ouqkCCnran9GCZoatAI6XTVfX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 Dave Taht <dave.taht@gmail.com>, Jamal Hadi Salim <jhs@mojatatu.com>,
 kernel@pengutronix.de, Cong Wang <xiyou.wangcong@gmail.com>,
 linux-can@vger.kernel.org, davem@davemloft.net
Message-ID: <0edf15df-b607-70f7-5fe8-2860eb663a53@pengutronix.de>
Subject: Re: [RFC] net: sch_generic: fq_codel vs pfifo_fast
References: <20190327165632.10711-1-mkl@pengutronix.de>
 <20190327113059.6b1224ab@shemminger-XPS-13-9360>
In-Reply-To: <20190327113059.6b1224ab@shemminger-XPS-13-9360>

--holF2ua9ouqkCCnran9GCZoatAI6XTVfX
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 3/27/19 7:30 PM, Stephen Hemminger wrote:
>> on CAN networking hardware we (the CAN community) experience a lot sil=
ent,
>> unwanted frame drops inside the kernel. (See first patch for details.)=
 So
>> here's a patch series to keep pfifo_fast as default scheduler for CAN =
hardware
>> by default.
>=20
> Why do you set fq_codel as default qdisc if you know it doesn't work ri=
ght for your
> environment. Is this a distro's want one value problem?

This is a many fold problem.

- Consider a random Linux developer attaching one of the mainline
supported USB-CAN adapters to his/her development laptop and doing some
random CAN test. As far a I heard all modern Linux distributions (but
not debian) enable fq_codel per kernel .config or via systemd. The user
will experiences dropped CAN frames on the first 1000 packages. This is
not a good user experience.

- From the user space point of view the sysctl net.core.default_qdisc
behaves a bit strange. Why can I enable a queuing discipline by default
that's known not to work on CAN devices. You might think the kernel
(should) know that CAN devices best work with pfifo_fast (or not
NET_SCHED at all).

- Addressing your question directly: Mixed environment. fq_codel works
great on Ethernet, but terrible on CAN. Of course I an use "tc" to
configure the way I want to. But from my point of view it would be nice,
if the kernel uses sane default...and handles the net.core.default_qdisc
default in a sane way.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--holF2ua9ouqkCCnran9GCZoatAI6XTVfX--

--B08wmT3aOsbSbdXvTtADrwYlMLJ2ufiSo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAlybzd0ACgkQWsYho5Hk
nSDXvwgAi+AoBehM1mWjzA8ehC4n01JWxl0eL0gycRenUTMsK6CLHcbuVLVewGxl
KuxTUEFTUjKj9KYcgAaFn71JBr5VKwdHfePhjAEL5O46zxfOf1lSv4WjDBSj1WOj
IyboBZuqoahvBtwTkEBEA5eZ6fLNsTth1jr+6ZEzaPkEWeLo9N6Gr/AKaYRfUfTa
HoWizlAj56Tn0ak6eHEZc+S1ZM3xJakHf/zXzI1TGojlb+tsWGmDWkitPXJ12eSh
dscI4Tcyo6KGSqdIfp5BrQ5CLsRVTMg8nIz4k8jMPQCXvqKLKTXZ+kUEAfW+UFBb
cPj1qzgR70Q1NOwxJnbDj2hNjvXeOw==
=szgw
-----END PGP SIGNATURE-----

--B08wmT3aOsbSbdXvTtADrwYlMLJ2ufiSo--
