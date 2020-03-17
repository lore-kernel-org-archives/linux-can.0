From: Mauro Carvalho Chehab <mchehab+huawei-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/12] docs: dt: fix references to m_can.txt file
Date: Tue, 17 Mar 2020 15:06:09 +0100
Message-ID: <20200317150609.4d5c7c71@coco.lan>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
        <db67f9bc93f062179942f1e095a46b572a442b76.1584450500.git.mchehab+huawei@kernel.org>
        <376dba43-84cc-6bf9-6c69-270c689caf37@pengutronix.de>
        <60f77c6f-0536-1f50-1b49-2f604026a5cb@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <60f77c6f-0536-1f50-1b49-2f604026a5cb-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org>
Cc: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linux Doc Mailing List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Benjamin Gaignard <benjamin.gaignard-qxv4g6HH51o@public.gmane.org>, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

Em Tue, 17 Mar 2020 08:29:45 -0500
Dan Murphy <dmurphy-l0cyMroinI0@public.gmane.org> escreveu:

> Hello
>=20
> On 3/17/20 8:17 AM, Marc Kleine-Budde wrote:
> > On 3/17/20 2:10 PM, Mauro Carvalho Chehab wrote: =20
> >> This file was converted to json and renamed. Update its
> >> references accordingly.
> >>
> >> Fixes: 824674b59f72 ("dt-bindings: net: can: Convert M_CAN to json-sch=
ema") =20
>=20
> I am trying to find out where the above commit was applied
>=20
> I don't see it in can-next or linux-can. I need to update the tcan dt=20
> binding file as it was missed.
>=20
> And I am not sure why the maintainers of these files were not CC'd on=20
> the conversion of this binding.

=46rom Next/merge.log:

Merging devicetree/for-next (d047cd8a2760 scripts/dtc: Update to upstream v=
ersion v1.6.0-2-g87a656ae5ff9)
$ git merge devicetree/for-next
Removing scripts/dtc/libfdt/Makefile.libfdt
Removing scripts/dtc/Makefile.dtc
...
 create mode 100644 Documentation/devicetree/bindings/net/can/bosch,m_can.y=
aml
 delete mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt

It sounds that those came from DT for-next branch.

Thanks,
Mauro
