From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2019-12-03
Date: Tue, 03 Dec 2019 11:14:57 -0800 (PST)
Message-ID: <20191203.111457.631787255568854644.davem@davemloft.net>
References: <20191203104703.14620-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191203104703.14620-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue,  3 Dec 2019 11:46:57 +0100

> this is a pull request of 6 patches for net/master.
> 
> The first two patches are against the MAINTAINERS file and adds Appana
> Durga Kedareswara rao as maintainer for the xilinx-can driver and Sriram
> Dash for the m_can (mmio) driver.
> 
> The next patch is by Jouni Hogander and fixes a use-after-free in the
> slcan driver.
> 
> Johan Hovold's patch for the ucan driver fixes the non-atomic allocation
> in the completion handler.
> 
> The last two patches target the xilinx-can driver. The first one is by
> Venkatesh Yadav Abbarapu and skips the error message on deferred probe,
> the second one is by Srinivas Neeli and fixes the usage of the skb after
> can_put_echo_skb().

Pulled, thanks Marc.
