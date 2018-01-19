From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2018-01-18
Date: Thu, 18 Jan 2018 21:16:54 -0500 (EST)
Message-ID: <20180118.211654.188109268503805411.davem@davemloft.net>
References: <20180118101507.17943-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180118101507.17943-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 18 Jan 2018 11:15:05 +0100

> this is a pull reqeust of two patches for net/master:
> 
> The syzkaller project triggered two WARN_ONCE() in the af_can code from
> userspace and we decided to replace it by a pr_warn_once().

Pulled, thanks Marc.
