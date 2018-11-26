From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V6 1/2] Documentation: can: flexcan: add stop mode
 property to  device tree
Date: Mon, 26 Nov 2018 14:06:19 -0600
Message-ID: <20181126200619.GA1595@bogus>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
 <20181123083304.3232-2-qiangqing.zhang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123083304.3232-2-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Aisheng DONG <aisheng.dong@nxp.com>, Joakim Zhang <qiangqing.zhang@nxp.com>
List-Id: linux-can.vger.kernel.org

On Fri, 23 Nov 2018 08:35:29 +0000, Joakim Zhang wrote:
> From: Aisheng Dong <aisheng.dong@nxp.com>
> 
> The FlexCAN controller can parse the stop mode property to enable CAN
> self wakeup feature.
> 
> Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
> ChangeLog:
> V1->V2:
> 	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
> V2->V6:
> 	*no change.
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
