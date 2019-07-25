From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH][next] can: kvaser_pciefd: remove redundant negative check
 on trigger
Date: Thu, 25 Jul 2019 14:37:08 +0200
Message-ID: <5D39A274.1000800@bfs.de>
References: <20190725112509.1075-1-colin.king@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725112509.1075-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S . Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-can.vger.kernel.org



Am 25.07.2019 13:25, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The check to see if trigger is less than zero is always false, trigger
> is always in the range 0..255.  Hence the check is redundant and can
> be removed.
> 
> Addresses-Coverity: ("Logically dead code")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/can/kvaser_pciefd.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/can/kvaser_pciefd.c b/drivers/net/can/kvaser_pciefd.c
> index 3af747cbbde4..68e00aad0810 100644
> --- a/drivers/net/can/kvaser_pciefd.c
> +++ b/drivers/net/can/kvaser_pciefd.c
> @@ -652,9 +652,6 @@ static void kvaser_pciefd_pwm_stop(struct kvaser_pciefd_can *can)
>  	top = (pwm_ctrl >> KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT) & 0xff;
>  
>  	trigger = (100 * top + 50) / 100;
> -	if (trigger < 0)
> -		trigger = 0;
> -
	to be fair i do not understand the calculation here here.
	(100*top+50)/100 = top+50/100

	but seems to be int so it should be =top

	did i missunderstand something here ?

	re,
	 wh


>  	pwm_ctrl = trigger & 0xff;
>  	pwm_ctrl |= (top & 0xff) << KVASER_PCIEFD_KCAN_PWM_TOP_SHIFT;
>  	iowrite32(pwm_ctrl, can->reg_base + KVASER_PCIEFD_KCAN_PWM_REG);
