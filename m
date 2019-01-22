From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 04/11] arm64: dts: renesas: Add Si-Linux EK874 board
 support
Date: Tue, 22 Jan 2019 15:53:45 +0100
Message-ID: <20190122145345.lqwymtx65zgc4tgo@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-5-git-send-email-fabrizio.castro@bp.renesas.com>
 <CAMuHMdVvMZWNrPfWrOmyFoK+oBu69N_G8s1U4mdAQdt_uj+N2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVvMZWNrPfWrOmyFoK+oBu69N_G8s1U4mdAQdt_uj+N2g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <mic>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 17, 2019 at 12:05:59PM +0100, Geert Uytterhoeven wrote:
> On Wed, Jan 16, 2019 at 7:38 PM Fabrizio Castro
> <fabrizio.castro@bp.renesas.com> wrote:
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > The EK874 development kit from Silicon Linux is made of CAT874 (the main
> > board) and CAT875 (the sub board that goes on top of CAT874).
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> 
> Pending acceptance of the DT bindings
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for v5.1.
