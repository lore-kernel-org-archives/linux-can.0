From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: J1939 support: plans for integration?
Date: Wed, 28 Nov 2012 16:04:12 +0100
Message-ID: <50B627EC.7020506@pengutronix.de>
References: <50AE12C5.2070501@ilv.uni-kiel.de> <20121123055240.GA17495@vandijck-laurijssen.be> <50B34AC9.1010306@ilv.uni-kiel.de> <20121128134323.GE40463@vandijck-laurijssen.be> <50B615E5.9040903@pengutronix.de> <20121128150007.GF40463@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig34BA96126EB101DDF77732EF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41743 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755505Ab2K1PEO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 28 Nov 2012 10:04:14 -0500
In-Reply-To: <20121128150007.GF40463@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Christoph Appel <cappel@ilv.uni-kiel.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig34BA96126EB101DDF77732EF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 11/28/2012 04:00 PM, Kurt Van Dijck wrote:
> On Wed, Nov 28, 2012 at 02:47:17PM +0100, Marc Kleine-Budde wrote:
>> On 11/28/2012 02:43 PM, Kurt Van Dijck wrote:
>>> On Mon, Nov 26, 2012 at 11:56:09AM +0100, Christoph Appel wrote:
>>>> Hello Kurt,
>>>>
>>>> Am 23.11.2012 06:52, schrieb Kurt Van Dijck:
>>>>> Hi,
>>>>>
>>> [...]
>>>>> How do you use the current J1939 stack?
>>>> I am in the early process of evaluating possibilities
>>>> deploying J1939 in farm machinery (primary
>>>> data logging purposes with a couple of bus requests).
>>>
>>> FYI, we (EIA Electronics) have certified a Virtual Terminal
>>> using this j1939 stack. The certification process went
>>> very smooth for the networking tests.
>>
>> like telnet?
> telnet on j1939?
>=20
> No, I meant the test that are preformed during this isobus certificatio=
n
> on the isobus (J1939) networking level, like dynamic addressing behavio=
ur,
> Transport protocol, ...
> A beautifull set of nasty corner cases is verified then.
> I was a bit curious to the results since I had spent some time on that =
code.
>=20
> Being certified at least means that the j1939 stack, together with the =
userspace programs,
> is functionally ready for production.
>=20
> Isobus (on CAN networking equal to j1939) has become the 'de facto' sta=
ndard for agriculture
> machinery...

\o/ - one step closer to world domination

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig34BA96126EB101DDF77732EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlC2J+wACgkQjTAFq1RaXHN91gCdEkIsUmgGpibb/MQ7woYzXRQ9
fhoAnAkCmtBueoCvjFhs8vnSWm6tb32O
=ARII
-----END PGP SIGNATURE-----

--------------enig34BA96126EB101DDF77732EF--
