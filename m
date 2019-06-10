From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2019-06-07
Date: Sun, 09 Jun 2019 19:44:19 -0700 (PDT)
Message-ID: <20190609.194419.1092823681840105677.davem@davemloft.net>
References: <20190607211541.16095-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190607211541.16095-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  7 Jun 2019 23:15:32 +0200

> this is a pull reqeust of 9 patches for net/master.
> 
> The first patch is by Alexander Dahl and removes a duplicate menu entry from
> the Kconfig. The next patch by Joakim Zhang fixes the timeout in the flexcan
> driver when setting small bit rates. Anssi Hannula's patch for the xilinx_can
> driver fixes the bittiming_const for CAN FD core. The two patches by Sean
> Nyekjaer bring mcp25625 to the existing mcp251x driver. The patch by Eugen
> Hristev implements an errata for the m_can driver. YueHaibing's patch fixes the
> error handling ing can_init(). The patch by Fabio Estevam for the flexcan
> driver removes an unneeded registration message during flexcan_probe(). And the
> last patch is by Willem de Bruijn and adds the missing purging the  socket
> error queue on sock destruct.

Pulled, thanks Marc.
