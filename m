From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v4 2/6] dt-bindings: net: can: binding for CTU CAN FD
 open-source IP core.
Date: Tue, 4 Aug 2020 11:20:21 +0200
Message-ID: <20200804092021.yd3wisz3g2ed6ioe@duo.ucw.cz>
References: <cover.1596408856.git.pisa@cmp.felk.cvut.cz>
 <701442883f2b439637ff84544745725bdee7bcf8.1596408856.git.pisa@cmp.felk.cvut.cz>
 <20200804091817.yuf6s26bclehpwwi@duo.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lug7fvks3zpvncaz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200804091817.yuf6s26bclehpwwi@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: pisa@cmp.felk.cvut.cz
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org, mkl@pengutronix.de, socketcan@hartkopp.net, wg@grandegger.com, davem@davemloft.net, robh+dt@kernel.org, mark.rutland@arm.com, c.emde@osadl.org, armbru@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, martin.jerabek01@gmail.com, ondrej.ille@gmail.com, jnovak@fel.cvut.cz, jara.beran@gmail.com, porazil@pikron.com
List-Id: linux-can.vger.kernel.org


--lug7fvks3zpvncaz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2020-08-04 11:18:17, Pavel Machek wrote:
> Hi!
>=20
> > The commit text again to make checkpatch happy.
>=20
> ?
>=20
>=20
> > +    oneOf:
> > +      - items:
> > +          - const: ctu,ctucanfd
> > +          - const: ctu,canfd-2
> > +      - const: ctu,ctucanfd
>=20
> For consistency, can we have ctu,canfd-1, ctu,canfd-2?

Make it ctu,ctucanfd-1, ctu,ctucanfd-2... to make it consistent with
the file names.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--lug7fvks3zpvncaz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXykoVQAKCRAw5/Bqldv6
8vYsAKCeIjfDLEJs016P2eTK3X+VulDfHACgu11rZttuoExM+oIWv21xWoEtvPo=
=5qpT
-----END PGP SIGNATURE-----

--lug7fvks3zpvncaz--
