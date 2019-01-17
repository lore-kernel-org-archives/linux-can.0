From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Date: Thu, 17 Jan 2019 13:19:19 +0100
Message-ID: <20190117121919.c5u66sorut5a5nib@verge.net.au>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <bb5b27ed-a077-f639-b97b-4da22c9bb3ad@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <bb5b27ed-a077-f639-b97b-4da22c9bb3ad@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>
Cc: Fabrizio Castro <fabrizio.castro@bp.renesas.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Biju Das <biju.das@bp.renesas.com>, Magnus Damm <magnus.damm@gmail.com>, "David S. Miller" <davem@davemloft.net>, Geert Uytterhoeven <geert+renesas@glider.be>, Thierry Reding <treding@nvidia.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Kevin Hilman <khilman@baylibre.com>, Johan Hovold <johan@kernel.org>, Lukasz Majewski <lukma@denx.de>, Michal Simek <monstr@monstr.eu>, Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>, Martin Blumenstingl <martin.bl>
List-Id: linux-can.vger.kernel.org

On Thu, Jan 17, 2019 at 12:17:56PM +0100, Andreas Färber wrote:
> Hi Fabrizio,
> 
> Am 16.01.19 um 19:37 schrieb Fabrizio Castro:
> > From: Biju Das <biju.das@bp.renesas.com>
> > 
> > Add Silicon Linux to the list of devicetree vendor prefixes.
> > 
> > Website: http://www.si-linux.co.jp
> > 
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 4b1a2a8..02a7037 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -344,6 +344,7 @@ sgx	SGX Sensortech
> >  sharp	Sharp Corporation
> >  shimafuji	Shimafuji Electric, Inc.
> >  si-en	Si-En Technology Ltd.
> > +si-linux	Silicon Linux Corporation
> 
> With the website being Japanese only, I haven't been able to confirm the
> spelling of the company name. Looks sensible though.

According to the company web site
(http://si-linux.co.jp/index.php?%E4%BC%9A%E7%A4%BE%E6%A1%88%E5%86%85)
the company name is.

Japanese: シリコンリナックス株式会社
English:  Silicon Linux Corporation

And in my opinion these are equivalent (although other translations of
the corporation bit are possible).

> Due to "en" coming before "five" I've double-checked that elsewhere we
> do order dashes before letters, so placement in file and tab-indentation
> is fine, too.
> 
> >  sifive	SiFive, Inc.
> >  sigma	Sigma Designs, Inc.
> >  sii	Seiko Instruments, Inc.
> 
> Personally I would drop the full stop at the end of the subject, but anyway:
> 
> Reviewed-by: Andreas Färber <afaerber@suse.de>
> 
> Thanks,
> Andreas
> 
> P.S. Please double-check how this excessive CC list came to life!
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
> 
