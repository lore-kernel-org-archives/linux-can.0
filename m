From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Subject: Re: [PATCH 0/2] leds: drop led_trigger_rename_static()
Date: Fri, 15 Jun 2018 22:49:48 +0200
Message-ID: <ca250930-59ac-6b41-dda5-b9ce3285de0d@gmail.com>
References: <20180518085333.26187-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180518085333.26187-1-u.kleine-koenig@pengutronix.de>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Pavel Machek <pavel@ucw.cz>, Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: linux-leds@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

Hi,

I need can or net maintainer's ack for merging this
set via LED tree. It's been awaiting feedback for a few weeks
now and it is blocking another set depending on it.


On 05/18/2018 10:53 AM, Uwe Kleine-König wrote:
> Hello,
> 
> initially I prepared a patch to fix the broken things in
> led_trigger_rename_static(), but given that there is only the
> can-trigger driver that makes use of this function and the netdev
> trigger implements a super set of the can-trigger, removing both the
> can-trigger and the broken function seems sensible.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (2):
>    can: drop led trigger support
>    leds: remove unused function led_trigger_rename_static()
> 
>   drivers/leds/led-triggers.c           |  13 ---
>   drivers/net/can/Kconfig               |  11 --
>   drivers/net/can/Makefile              |   2 -
>   drivers/net/can/at91_can.c            |  10 --
>   drivers/net/can/c_can/c_can.c         |  11 --
>   drivers/net/can/dev.c                 |   5 -
>   drivers/net/can/flexcan.c             |   8 --
>   drivers/net/can/ifi_canfd/ifi_canfd.c |   9 --
>   drivers/net/can/led.c                 | 143 --------------------------
>   drivers/net/can/m_can/m_can.c         |   9 --
>   drivers/net/can/rcar/rcar_can.c       |   8 --
>   drivers/net/can/rcar/rcar_canfd.c     |   7 --
>   drivers/net/can/rx-offload.c          |   2 -
>   drivers/net/can/sja1000/sja1000.c     |  15 +--
>   drivers/net/can/spi/hi311x.c          |   8 --
>   drivers/net/can/spi/mcp251x.c         |  10 --
>   drivers/net/can/sun4i_can.c           |   7 --
>   drivers/net/can/ti_hecc.c             |   9 --
>   drivers/net/can/usb/mcba_usb.c        |   7 --
>   drivers/net/can/usb/usb_8dev.c        |  11 --
>   drivers/net/can/xilinx_can.c          |   9 --
>   include/linux/can/dev.h               |  10 --
>   include/linux/can/led.h               |  54 ----------
>   include/linux/leds.h                  |  18 ----
>   24 files changed, 1 insertion(+), 395 deletions(-)
>   delete mode 100644 drivers/net/can/led.c
>   delete mode 100644 include/linux/can/led.h
> 

-- 
Best regards,
Jacek Anaszewski
