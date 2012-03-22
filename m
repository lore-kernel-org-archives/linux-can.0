From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 10:32:24 +0100
Message-ID: <4F6AF1A8.1010001@pengutronix.de>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be> <4F69EC19.7090205@grandegger.com> <4F69EE38.9000904@hartkopp.net> <20120322092456.GB426@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC8C015A3EE7EAE46E02F3C43"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57442 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956Ab2CVJck (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Mar 2012 05:32:40 -0400
In-Reply-To: <20120322092456.GB426@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, dev@sebastianhaas.info, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC8C015A3EE7EAE46E02F3C43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2012 10:24 AM, Kurt Van Dijck wrote:
> On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
>> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
>>
>>> Also DLC=3D9 means 12 bytes, DLC=3D10 means 16 bytes, DLC=3D15 means =
64 bytes.
>>> This may even change in the final spec.
>>
>> Yep!
>=20
> Although the precise coding is not final yet, I'd propose to not use th=
at coding
> in the ABI for these reasons:
> * The reason of fitting a DLC in 4 bits makes sense on the wire
>   but not on the ABI. We still use an u8!
> * Decoding & encoding between real length & DLC IMO is best done next t=
o the
>   chips register access.

Yes - probably with a helper function.

>>>>> 3. Will these differences be visible in the CAN registers? Is this =
relevant?
>>>> Without hardware, it's a bit early to predict. I guess it will be vi=
sible, but
>>>> not relevant since that's driver stuff.
>>>
>>> As CANFD controllers also supports CAN2.0 frames, they must provide t=
he
>>> the relevant information somehow, similar to EFF and SFF.
> I doubt this.
> EFF & SFF share the same bus. CANFD vs. CAN2.0 is not a per-frame thing=
=2E You
> have configured it yourself at chip initialization time...

Although I haven't seen any data sheet nor hardware I suppose you have
to configure a chip for CANFD during initialisation.

Oliver can you ask at Bosch if we can get a manual for the upcoming CAN
FD chips?

>>>> I did not get into real drivers yet...
>>>>>
>>>>> What i got from the iCC was that when you have a partly migrated ne=
twork and
>>>>> you want to run e.g. a fast firmware upload between two CAN FD capa=
ble nodes,
>>>>> the other (standard CAN 2.0b) nodes have to be in listen only mode =
to not jam
>>>>> the bus with error frames.
>>>
>>> Due to the bit-rate switching, a assume.
>>
>>
>> Yes - the 'old' controllers would put error frames on the fast payload=
 data.
>>
> FYI: The bitrate switch is not the only cause.
> The bitstream on the wire for 'equal' CANFD & CAN2.0 frames is differen=
t.
> A regular CAN2.0 chip will signal protocol violations.

IIRC in the data phase CANFD doesn't use the prop seg anymore and some
reserved bits in the frame are now used.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigC8C015A3EE7EAE46E02F3C43
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9q8awACgkQjTAFq1RaXHM53QCeLzQ2/M0PtKlhcPQQ4+AsjiTB
BBsAmwSq9seaW+XpTO7m7DYH3Nt7O2ES
=XnTU
-----END PGP SIGNATURE-----

--------------enigC8C015A3EE7EAE46E02F3C43--
