From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2015-06-21
Date: Tue, 23 Jun 2015 06:43:38 -0700 (PDT)
Message-ID: <20150623.064338.1193972764545855895.davem@davemloft.net>
References: <1434906299-19452-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1434906299-19452-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 21 Jun 2015 19:04:58 +0200

> this is a, probably too late, pull request for v4.1.
> 
> Oliver Hartkopp fixed a bug in the generic CAN frame handling code, which may
> lead to loss of CAN frames. It was introduced during v4.1 development.
> 
> Please queue via net/master if possible, net-next/master otherwise. I've added
> stable on Cc, just in case.

Pulled, thanks.
