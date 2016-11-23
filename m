From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/3] arm64: dts: r8a7796: Add CAN/CAN FD support
Date: Wed, 23 Nov 2016 15:29:38 +0100
Message-ID: <20161123142938.GF9057@verge.net.au>
References: <1479903243-1860-1-git-send-email-chris.paterson2@renesas.com>
 <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <f358442c-8373-328c-1270-709498c133f5@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Chris Paterson <chris.paterson2@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-can@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, Wolfgang Grandegger <wg@grandegger.com>
List-Id: linux-can.vger.kernel.org

On Wed, Nov 23, 2016 at 02:18:13PM +0100, Marc Kleine-Budde wrote:
> On 11/23/2016 01:14 PM, Chris Paterson wrote:
> > This patch series adds CAN and CAN FD support to the r8a7796.
> > 
> > Based on renesas-devel-20161122-v4.9-rc6.
> > 
> > Chris Paterson (3):
> >   arm64: dts: r8a7796: Add CAN external clock support
> >   arm64: dts: r8a7796: Add CAN support
> >   arm64: dts: r8a7796: Add CAN FD support
> > 
> >  .../devicetree/bindings/net/can/rcar_can.txt       | 12 +++--
> >  .../devicetree/bindings/net/can/rcar_canfd.txt     | 12 +++--
> >  arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 61 ++++++++++++++++++++++
> >  3 files changed, 75 insertions(+), 10 deletions(-)
> 
> For all three:
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Who takes this series?

I would like to see these patches split up so that the
.../devicetree/bindings/ portions can go through you whole
the arch/arm64/boot/dts/renesas/ portions go thorugh my renesas tree.

Regarding the arch/arm64/boot/dts/renesas/ portion, I would like
some consideration given to what effect enabling memory above 4Gb
(64bit addressing) would have.
