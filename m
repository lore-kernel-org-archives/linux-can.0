From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: pull-request: can 2015-07-13
Date: Tue, 14 Jul 2015 18:41:19 +0200
Message-ID: <55A53BAF.5070401@hartkopp.net>
References: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:39283 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbGNQl1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 14 Jul 2015 12:41:27 -0400
In-Reply-To: <1436772148-9805-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

Hi Marc,

you did not sent this mail to Dave but only to linux-can ML.

Btw. why didn't you create a single patch with a single commit msg?

IMO you fix a single issue ... whether it is about 
netif_receive_skb()/netif_rx()/netif_rx() is not really relevant.

Regards,
Oliver


On 13.07.2015 09:22, Marc Kleine-Budde wrote:
> Hello David,
>
> this is a pull request of 12 patches by me.
>
> This series fixes the use of the skb after netif_receive_skb() / netif_rx()
> which exists in several driver.
>
> Marc
> ---
>
> The following changes since commit cee9f6d0186a586c8023bc91c8a4cf8a088855e5:
>
>    Merge tag 'linux-can-fixes-for-4.2-20150712' of git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can (2015-07-12 22:24:01 -0700)
>
> are available in the git repository at:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can.git tags/linux-can-fixes-for-4.2-20150713
>
> for you to fetch changes up to 95935983f875ac91c43eef04bc56199cc39face6:
>
>    can: pcan_usb: don't touch skb after netif_rx() (2015-07-13 08:56:04 +0200)
>
> ----------------------------------------------------------------
> linux-can-fixes-for-4.2-20150713
>
> ----------------------------------------------------------------
> Marc Kleine-Budde (12):
>        can: at91_can: don't touch skb after netif_receive_skb()/netif_rx()
>        can: flexcan: don't touch skb after netif_receive_skb()
>        can: bfin_can: don't touch skb after netif_rx()
>        can: grcan: don't touch skb after netif_rx()
>        can: slcan: don't touch skb after netif_rx_ni()
>        can: ti_heccn: don't touch skb after netif_rx()
>        can: cc770: don't touch skb after netif_rx()
>        can: sja1000: don't touch skb after netif_rx()
>        can: esd_usb2: don't touch skb after netif_rx()
>        can: ems_usb: don't touch skb after netif_rx()
>        can: usb_8dev: don't touch skb after netif_rx()
>        can: pcan_usb: don't touch skb after netif_rx()
>
>   drivers/net/can/at91_can.c                  | 8 ++++----
>   drivers/net/can/bfin_can.c                  | 6 ++----
>   drivers/net/can/cc770/cc770.c               | 4 ++--
>   drivers/net/can/flexcan.c                   | 7 +++----
>   drivers/net/can/grcan.c                     | 3 ++-
>   drivers/net/can/sja1000/sja1000.c           | 6 ++----
>   drivers/net/can/slcan.c                     | 2 +-
>   drivers/net/can/ti_hecc.c                   | 2 +-
>   drivers/net/can/usb/ems_usb.c               | 6 ++----
>   drivers/net/can/usb/esd_usb2.c              | 6 ++----
>   drivers/net/can/usb/peak_usb/pcan_usb.c     | 7 +++----
>   drivers/net/can/usb/peak_usb/pcan_usb_pro.c | 4 ++--
>   drivers/net/can/usb/usb_8dev.c              | 6 ++----
>   13 files changed, 28 insertions(+), 39 deletions(-)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
