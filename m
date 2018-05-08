From: David Miller <davem@davemloft.net>
Subject: Re: pull-request: can 2018-05-08
Date: Tue, 08 May 2018 10:20:12 -0400 (EDT)
Message-ID: <20180508.102012.185189397441607418.davem@davemloft.net>
References: <20180508092831.28247-1-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180508092831.28247-1-mkl@pengutronix.de>
Sender: netdev-owner@vger.kernel.org
To: mkl@pengutronix.de
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de
List-Id: linux-can.vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue,  8 May 2018 11:28:24 +0200

> this is a pull request for 7 patches for net/master.
> 
> The first patch is by Jakob Unterwurzacher and increases the severity of
> bus-off messages in the generic CAN device infrastructure. The next two patches
> are by Uwe Kleine-König and fix the endianess detection in the flexcan driver.
> Jimmy Assarsson's patch for the kvaser driver corrects the stats counter for
> dropped tx-messages. Geert Uytterhoeven provides one patch and Sergei Shtylyov
> two patches for the rcan_canfd device tree binding description.

Pulled, thanks Marc.
