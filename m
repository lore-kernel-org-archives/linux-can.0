From: Jean Delvare <jdelvare@suse.com>
Subject: Re: Request for proper hardware dependencies
Date: Tue, 13 May 2014 17:31:30 +0200
Message-ID: <1399995090.4341.401.camel@chaos.site>
References: <21352.42929.159377.243822@gargle.gargle.HOWL>
	 <53722E20.9080405@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nat28.tlf.novell.com ([130.57.49.28]:55117 "EHLO
	nat28.tlf.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440AbaEMPbf (ORCPT
	<rfc822;groupwise-linux-can@vger.kernel.org:0:0>);
	Tue, 13 May 2014 11:31:35 -0400
In-Reply-To: <53722E20.9080405@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, linux-can@vger.kernel.org

Le Tuesday 13 May 2014 =C3=A0 16:37 +0200, Marc Kleine-Budde a =C3=A9cr=
it :
> On 05/06/2014 11:13 AM, Uwe Bonnes wrote:
> > Hallo,
> >=20
> > the number of kernel driver exploded in the last years and so the k=
ernel
> > configuration. Distribution mantainers must at some point limit com=
piled
> > driver at least partly to the driver needed one on a given arch. Ho=
wever the
> > distribution maintainers mosty can't always know what they deal abo=
ut.
> >=20
> > For me this resulted in loosing socketcan from the Opensuse Kernels=
 in
> > between 12.3 up to some weeks ago, as one maintainer (not Jean) mat=
ched
> > socketcan in error with "SPI" which is not related to normal deskto=
p
> > machines. See
> > http://lists.opensuse.org/archive/opensuse-bugs/2014-01/msg00970.ht=
ml.
> > Opensuse 13.1 recent kernels and the next release will have socketc=
an again,
> > but in the course of the discussion Jean Delvare pointed some weak =
points in
> > socketcan configuration, leading to compilation on driver not neede=
d on some
> > archs:
> >=20
> >>>>>> "Jean" =3D=3D Jean Delvare <jdelvare@suse.com> writes:
> >=20
> >     Jean> For the record, hardware dependencies on CAN device drive=
rs aren't
> >     Jean> that bad in general, I've seen worse in several other sub=
systems.
> >=20
> >     Jean> That being said, there is still some room for improvement=
=2E For
> >     Jean> example, CAN_AT91 could depend on ARCH_AT91 instead of ju=
st ARM,
> >     Jean> PCH_CAN could depend on X86, and a few drivers with "ISA"=
 in their
> >     Jean> description should probably depend on ISA. I'm also not s=
ure why
> >     Jean> CAN_MSCAN alternatively depends on M68K instead of just
> >     Jean> ARM. That's just from a quick look from the non-initiate =
I am,
> >     Jean> there may be more dependency fix-ups possible.  I'll send=
 a few
> >     Jean> patches out if I can find some time for that today.
> >=20
> > Please consider openly his patches or even better consider a cleanu=
p yourself.
>=20
> I've applied all 3 patches by Jean to can-next.

Great, thank you!

--=20
Jean Delvare
SUSE L3 Support

