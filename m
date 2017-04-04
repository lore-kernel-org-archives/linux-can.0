From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: pull-request: can-next 2017-03-03
Date: Tue, 4 Apr 2017 23:02:27 +0200
Message-ID: <71c7af28-07fe-8009-863e-8ed19f109f5b@hartkopp.net>
References: <f4c403dd-50c0-be1a-90eb-1d45d3bc1afd@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:12597 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbdDDVCh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Apr 2017 17:02:37 -0400
In-Reply-To: <f4c403dd-50c0-be1a-90eb-1d45d3bc1afd@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello Marc,

I wonder why the net namespace patches are pushed to upstream without 
some more feedback from others - and the M_CAN, PEAK PCI FD and mcba_usb 
are still pending for nearly 3 month.

This is not really transparent for the driver contributors :-(

Regards,
Oliver

On 04/04/2017 05:47 PM, Marc Kleine-Budde wrote:
> Hello David,
>
> this is a pull request of 5 patches for net-next/master.
>
> There are two patches by Yegor Yefremov which convert the ti_hecc
> driver into a DT only driver, as there is no in-tree user of the old
> platform driver interface anymore. The next patch by Mario Kicherer
> adds network namespace support to the can subsystem. The last two
> patches by Akshay Bhat add support for the holt_hi311x SPI CAN driver.
>
> regards,
> Marc
>
> ---
>
> The following changes since commit 822f9bb104c9d1d2dea3669f1941558c6304cf92:
>
>   soreuseport: use "unsigned int" in __reuseport_alloc() (2017-04-03 19:06:38 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git tags/linux-can-next-for-4.13-20170404
>
> for you to fetch changes up to 57e83fb9b7468c75cb65cde1d23043553c346c6d:
>
>   can: hi311x: Add Holt HI-311x CAN driver (2017-04-04 17:35:59 +0200)
>
> ----------------------------------------------------------------
> linux-can-next-for-4.13-20170404
>
> ----------------------------------------------------------------
> Akshay Bhat (2):
>       can: holt_hi311x: document device tree bindings
>       can: hi311x: Add Holt HI-311x CAN driver
>
> Mario Kicherer (1):
>       can: initial support for network namespaces
>
> Yegor Yefremov (2):
>       can: ti_hecc: Add TI HECC DT binding documentation
>       can: ti_hecc: Convert TI HECC driver to DT only driver
>
>  .../devicetree/bindings/net/can/holt_hi311x.txt    |   24 +
>  .../devicetree/bindings/net/can/ti_hecc.txt        |   32 +
>  drivers/net/can/spi/Kconfig                        |    6 +
>  drivers/net/can/spi/Makefile                       |    1 +
>  drivers/net/can/spi/hi311x.c                       | 1076 ++++++++++++++++++++
>  drivers/net/can/ti_hecc.c                          |  170 ++--
>  include/linux/can/core.h                           |    7 +-
>  include/linux/can/platform/ti_hecc.h               |   44 -
>  include/net/net_namespace.h                        |    4 +
>  include/net/netns/can.h                            |   31 +
>  net/can/af_can.c                                   |  122 ++-
>  net/can/af_can.h                                   |    4 +-
>  net/can/bcm.c                                      |   13 +-
>  net/can/gw.c                                       |    4 +-
>  net/can/proc.c                                     |  144 ++-
>  net/can/raw.c                                      |   92 +-
>  16 files changed, 1469 insertions(+), 305 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/can/holt_hi311x.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti_hecc.txt
>  create mode 100644 drivers/net/can/spi/hi311x.c
>  delete mode 100644 include/linux/can/platform/ti_hecc.h
>  create mode 100644 include/net/netns/can.h
>
