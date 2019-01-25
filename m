From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2019-01-22
Date: Thu, 24 Jan 2019 21:52:57 -0800 (PST)
Message-ID: <20190124.215257.2059094008992225611.davem@davemloft.net>
References: <20190122132116.7074-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190122132116.7074-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 22 Jan 2019 14:21:12 +0100

> this is a pull request of 4 patches for net/master.
> 
> The first patch by is by Manfred Schlaegl and reverts a patch that caused wrong
> warning messages in certain use cases. The next patch is by Oliver Hartkopp for
> the bcm that adds sanity checks for the timer value before using it to detect
> potential interger overflows. The last two patches are for the flexcan driver,
> YueHaibing's patch fixes the the return value in the error path of the
> flexcan_setup_stop_mode() function. The second patch is by Uwe Kleine-König and
> fixes a NULL pointer deref on older flexcan cores in flexcan_chip_start().

Pulled, thanks Marc.
