From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: fix NULL pointer exception during
 bringup
Date: Tue, 22 Jan 2019 14:35:26 +0100
Message-ID: <20190122133526.skqezcdd5hz547gh@pengutronix.de>
References: <20190122132116.7074-1-mkl@pengutronix.de>
 <20190122132116.7074-5-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190122132116.7074-5-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, kernel@pengutronix.de, linux-stable <stable@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On Tue, Jan 22, 2019 at 02:21:16PM +0100, Marc Kleine-Budde wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Commit cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
> introduced a loop letting i run up to (including) ARRAY_SIZE(regs->mb)
> and in the body accessed regs->mb[i] which is an out-of-bounds array
> access that then resulted in an access to an reserved register area.
> 
> Later this was changed by commit 0517961ccdf1 ("can: flexcan: Add
> provision for variable payload size") to iterate a bit differently but
> still runs one iteration too much resulting to call
> 
> 	flexcan_get_mb(priv, priv->mb_count)
> 
> which results in a WARN_ON and then a NULL pointer exception. This
> only affects devices compatible with "fsl,p1010-flexcan",
> "fsl,imx53-flexcan", "fsl,imx35-flexcan", "fsl,imx25-flexcan",
> "fsl,imx28-flexcan", so newer i.MX SoCs are not affected.
> 
> Fixes: cbffaf7aa09e ("can: flexcan: Always use last mailbox for TX")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Cc: linux-stable <stable@vger.kernel.org> # >= 4.20

Given that cbffaf7aa09e was backported to v4.19.x a fix is needed there,
too. The patch looks different but I already sent a patch to
stable@vger.k.o.

Not sure if ">= 4.20" should be adapted accordingly. cbffaf7aa09e was
backported resulting in commit 24e5589791d0 which made it into v4.19.6.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
