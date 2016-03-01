From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH] arm64: dts: r8a7795: Add CAN FD support
Date: Tue, 1 Mar 2016 16:12:24 +0300
Message-ID: <56D59538.2060100@cogentembedded.com>
References: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1456826640-23237-1-git-send-email-ramesh.shanmugasundaram@bp.renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>, mkl@pengutronix.de, wg@grandegger.com, horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chris.paterson2@renesas.com
List-Id: linux-can.vger.kernel.org

Hello.

On 3/1/2016 1:04 PM, Ramesh Shanmugasundaram wrote:

> Adds CAN FD controller node for r8a7795.
>
> Note: CAN FD controller register base address specified in R-Car Gen3
> Hardware User Manual v0.5E is incorrect. The correct address is:
>
> CAN FD - 0xe66c0000
>
> Signed-off-by: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>
> ---
> Hi All,
>
>     This patch is based on linux-next (tag:next-20160225) with the following
>     patches applied on top.
>
>     [PATCH v2] arm64: dts: r8a7795: Add CAN external clock support
>     [PATCH] arm64: dts: r8a7795: Add CAN support
>
>     The respective CAN subsystem changes are submitted separately here (https://www.mail-archive.com/linux-renesas-soc@vger.kernel.org/msg01388.html)
>
> Thanks,
> Ramesh
> ---
>   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index a88f8d8..5049ba6 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -553,6 +553,30 @@
>   			status = "disabled";
>   		};
>
> +		canfd: canfd@e66c0000 {

    The node name should still be "can@e66c0000", I think.

MBR, Sergei
