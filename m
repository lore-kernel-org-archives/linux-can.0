From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-11-10
Date: Sat, 11 Nov 2017 21:52:48 +0900 (KST)
Message-ID: <20171111.215248.1168618579941938559.davem@davemloft.net>
References: <20171110130730.6662-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171110130730.6662-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 10 Nov 2017 14:07:26 +0100

> this is a pull request for net/master.
> 
> The first patch by Richard Schütz for the c_can driver removes the false
> indication to support triple sampling for d_can. Gerhard Bertelsmann's
> patch for the sun4i driver improves the RX overrun handling. The patch
> by Stephane Grosjean for the peak_canfd driver adds the PCI ids for
> various new PCIe/M2 interfaces. Marek Vasut's patch for the ifi driver
> fix transmitter delay calculation.

Pulled, thanks Marc.
