From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2019-08-02
Date: Mon, 05 Aug 2019 14:45:09 -0700 (PDT)
Message-ID: <20190805.144509.1987672257878718335.davem@davemloft.net>
References: <20190802120038.18154-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190802120038.18154-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri,  2 Aug 2019 14:00:34 +0200

> this is a pull request of 4 patches for net/master.
> 
> The first two patches are by Wang Xiayang, they force that the string buffer
> during a dev_info() is properly NULL terminated.
> 
> The last two patches are by Tomas Bortoli and fix both a potential info leak of
> kernel memory to USB devices.

Pulled, thanks Marc.
