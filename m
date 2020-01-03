From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2020-01-02
Date: Thu, 02 Jan 2020 16:41:13 -0800 (PST)
Message-ID: <20200102.164113.762444597958242363.davem@davemloft.net>
References: <20200102160934.1524-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200102160934.1524-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu,  2 Jan 2020 17:09:25 +0100

> this is a pull request of 9 patches for net/master.
> 
> The first 5 patches target all the tcan4x5x driver. The first 3 patches
> of them are by Dan Murphy and Sean Nyekjaer and improve the device
> initialization (power on, reset and get device out of standby before
> register access). The next patch is by Dan Murphy and disables the INH
> pin device-state if the GPIO is unavailable. The last patch for the
> tcan4x5x driver is by Gustavo A. R. Silva and fixes an inconsistent
> PTR_ERR check in the tcan4x5x_parse_config() function.
> 
> The next patch is by Oliver Hartkopp and targets the generic CAN device
> infrastructure. It ensures that an initialized headroom in outgoing CAN
> sk_buffs (e.g. if injected by AF_PACKET).
> 
> The last 2 patches are by Johan Hovold and fix the kvaser_usb and gs_usb
> drivers by always using the current alternate setting not blindly the
> first one.

Pulled, thanks Marc.

 
