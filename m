From: "pankj.sharma" <pankj.sharma@samsung.com>
Subject: RE: [PATCH 0/2] can: m_can_platform: Bug fix of kernel panic for
Date: Fri, 6 Dec 2019 12:23:11 +0530
Message-ID: <021d01d5ac01$d55f1220$801d3660$@samsung.com>
References: <CGME20191119102134epcas5p4d3c1b18203e2001c189b9fa7a0e3aab5@epcas5p4.samsung.com>
        <1574158838-4616-1-git-send-email-pankj.sharma@samsung.com>
        <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <f0550b0b-6681-75a3-c58a-28f5b7ca0821@ti.com>
Content-Language: en-us
Sender: netdev-owner@vger.kernel.org
To: 'Dan Murphy' <dmurphy@ti.com>
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, rcsekar@samsung.com, pankaj.dubey@samsung.com, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



> From: Dan Murphy <dmurphy=40ti.com>
> Subject: Re: =5BPATCH 0/2=5D can: m_can_platform: Bug fix of kernel panic=
 for
>=20
> Pankaj
>=20
> On 11/19/19 4:20 AM, Pankaj Sharma wrote:
> > The current code is failing while clock prepare enable because of not
> > getting proper clock from platform device.
> > A device driver for CAN controller hardware registers itself with the
> > Linux network layer as a network device. So, the driver data for m_can
> > should ideally be of type net_device.
> >
> > Further even when passing the proper net device in probe function the
> > code was hanging because of the function m_can_runtime_resume()
> > getting recursively called from m_can_class_resume().
> >
> > Pankaj Sharma (2):
> >    can: m_can_platform: set net_device structure as driver data
> >    can: m_can_platform: remove unnecessary m_can_class_resume() call
>=20
> Did you CC: linux-stable for these?  We are probably going to have custom=
ers
> picking up 5.4 LTS and would need these bug fixes.
Hello Dan,=20
I haven=E2=80=99t=20copied=20to=20linux-stable,=20but=20the=20patches=20are=
=20already=20in=20linux-stable=20branch.=20=0D=0AYou=20can=20check=20in=20f=
ollowing=20link.=0D=0Ahttps://git.kernel.org/pub/scm/linux/kernel/git/stabl=
e/linux.git/log/?h=3Dlinux-5.4.y=0D=0A=0D=0APankaj=0D=0A=0D=0A>=20=0D=0A>=
=20Or=20at=20the=20very=20least=20see=20if=20the=20stable=20automation=20wi=
ll=20pick=20these=20up.=0D=0A>=20=0D=0A>=20Dan=0D=0A>=20=0D=0A=0D=0A=0D=0A
