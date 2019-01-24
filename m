From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: fix NULL pointer exception during
 bringup
Date: Thu, 24 Jan 2019 08:26:10 +0100
Message-ID: <20190124072610.7n2wzwiexdtvvh5p@pengutronix.de>
References: <20190122132116.7074-5-mkl@pengutronix.de>
 <20190123225745.3D239218A2@mail.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190123225745.3D239218A2@mail.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Sasha Levin <sashal@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-can.vger.kernel.org

Hello Sasha,

On Wed, Jan 23, 2019 at 10:57:44PM +0000, Sasha Levin wrote:
> [This is an automated email]

Not sure if I only state the obvious that was just missed by your
automation.
> 
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: cbffaf7aa09e can: flexcan: Always use last mailbox for TX.
> 
> The bot has tested the following trees: v4.20.3, v4.19.16.
> 
> v4.20.3: Failed to apply! Possible dependencies:
>     0517961ccdf1 ("can: flexcan: Add provision for variable payload size")
>     22233f7bf2c9 ("can: flexcan: FLEXCAN_IFLAG_MB: add () around macro argument")
>     5156c7b11f35 ("can: flexcan: move rx_offload_add() from flexcan_probe() to flexcan_open()")
>     7ad0f53a394b ("can: flexcan: flexcan_chip_start(): enable loopback mode in flexcan")
>     de3578c198c6 ("can: flexcan: add self wakeup support")
> 
> v4.19.16: Failed to apply! Possible dependencies:
>     0517961ccdf1 ("can: flexcan: Add provision for variable payload size")
>     22233f7bf2c9 ("can: flexcan: FLEXCAN_IFLAG_MB: add () around macro argument")
>     5156c7b11f35 ("can: flexcan: move rx_offload_add() from flexcan_probe() to flexcan_open()")
>     7ad0f53a394b ("can: flexcan: flexcan_chip_start(): enable loopback mode in flexcan")
>     de3578c198c6 ("can: flexcan: add self wakeup support")
> 
> 
> How should we proceed with this patch?

When I posted the commit I also posted one that fits on top of v4.19.x.
I would expect that the same also fits on v4.20.x. If not, tell me.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
