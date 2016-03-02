From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 2/2] arm64: dts: r8a7795: Add CAN support
Date: Wed, 2 Mar 2016 09:25:27 +0900
Message-ID: <20160302002527.GG17986@verge.net.au>
References: <1456737661-20538-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
 <1456737661-20538-3-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456737661-20538-3-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Sender: netdev-owner@vger.kernel.org
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
Cc: mkl@pengutronix.de, wg@grandegger.com, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, chris.paterson2@renesas.com
List-Id: linux-can.vger.kernel.org

On Mon, Feb 29, 2016 at 09:21:01AM +0000, Ramesh Shanmugasundaram wrote:
> Adds CAN controller nodes for r8a7795.
> 
> Note: CAN channel register base address mentioned in R-Car Gen3 Hardware
> User Manual v0.5E is incorrect. The corrected base addresses are:
> 
> CAN Channel 0 - 0xe6c30000
> CAN Channel 1 - 0xe6c38000
> 
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>

I have deferred this patch pending acceptance of the bindings
(basically patch 1/2). Please repost this patch or ping me once
that has happened.
