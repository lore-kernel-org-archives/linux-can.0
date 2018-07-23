From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2018-07-23
Date: Mon, 23 Jul 2018 11:02:41 -0700 (PDT)
Message-ID: <20180723.110241.1700809256849434700.davem@davemloft.net>
References: <20180723125843.391-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180723125843.391-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 23 Jul 2018 14:58:31 +0200

> this is a pull request of 12 patches for net/master.
> 
> The patch by Stephane Grosjean for the peak_canfd CAN driver fixes a problem
> with older firmware. The next patch is by Roman Fietze and fixes the setup of
> the CCCR register in the m_can driver. Nicholas Mc Guire's patch for the
> mpc5xxx_can driver adds missing error checking. The two patches by Faiz Abbas
> fix the runtime resume and clean up the probe function in the m_can driver. The
> last 7 patches by Anssi Hannula fix several problem in the xilinx_can driver.

Pulled, thanks Marc.
