From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 03/11] arm64: dts: renesas: Add Si-Linux CAT874 board
 support
Date: Tue, 22 Jan 2019 15:52:07 +0100
Message-ID: <20190122145206.ijjwzffwbazsnvrs@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdWhcH2=FS62jawZrMeSc_qKBS_SpDTMoVvhP2o736wtgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWhcH2=FS62jawZrMeSc_qKBS_SpDTMoVvhP2o736wtgg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <mic>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 17, 2019 at 12:04:51PM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 16, 2019 at 7:38 PM Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > Basic support for the Si-Linux board based on RZ/G2E:
> >   - Memory,
> >   - Main crystal,
> >   - Serial console
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> 
> Pending acceptance of the DT bindings
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I have applied the binding patch locally and intend to include
it in my next push. With that in mind I have also applied this patch
for v5.1.

> 
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/renesas/r8a774c0-cat874.dts
> 
> > +       chosen {
> > +               bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> 
> FWIW, the root and ip parameters won't do anything, until you add network
> support.

True, but I don't think that warrants a respin.

> 
> > +               stdout-path = "serial0:115200n8";
> > +       };
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
