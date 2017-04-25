From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2017-04-25
Date: Tue, 25 Apr 2017 11:21:26 -0400 (EDT)
Message-ID: <20170425.112126.232541678435322858.davem@davemloft.net>
References: <20170425121645.9946-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170425121645.9946-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 25 Apr 2017 14:16:42 +0200

> this is a pull request of three patches for net/master.
> 
> There are two patches by Stephane Grosjean for that add a new variant to the
> PCAN-Chip USB driver. The other patch is by Maksim Salau, which swtiches the
> memory for USB transfers from heap to stack.

I think you meant "from stack to heap", but anyways pulled thanks!
