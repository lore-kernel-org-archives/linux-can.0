From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2016-06-20
Date: Wed, 22 Jun 2016 16:30:02 -0400 (EDT)
Message-ID: <20160622.163002.416950357869278214.davem@davemloft.net>
References: <1466409630-6268-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1466409630-6268-1-git-send-email-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 20 Jun 2016 10:00:27 +0200

> this is a pull request of 3 patches for the upcoming linux-4.7 release.
> 
> The first patch is by Thor Thayer for the c_can/d_can driver. It fixes the
> registar access on Altera Cyclone devices, which caused CAN frames to have 0x0
> in the first two bytes incorrectly. Wolfgang Grandegger's patch for the at91
> driver fixes a hanging driver under high bus load situations. A patch for the
> gs_usb driver by Maximilian Schneider adds support for the bytewerk.org
> candleLight interface.

Pulled, thanks.
