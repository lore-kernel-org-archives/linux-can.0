From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v2] can: pcan_usb: don't provide CAN FD bittimings by
 non-FD adapters
Date: Thu, 06 Aug 2015 11:24:20 +0200
Message-ID: <55C327C4.7010807@hartkopp.net>
References: <1438848491-16234-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:19412 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754744AbbHFJYa (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Aug 2015 05:24:30 -0400
In-Reply-To: <1438848491-16234-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Stephane Grosjean <s.grosjean@peak-system.com>

Hi Marc,

On 06.08.2015 10:07, Marc Kleine-Budde wrote:
> The CAN FD data bittiming constants are provided via netlink only when there
> are valid CAN FD constants available in priv->data_bittiming_const.
>
> Due to the indirection of pointer assignments in the peak_usb driver the
> priv->data_bittiming_const never becomes NULL - not even for non-FD adapters.
>
> The data_bittiming_const points to zero'ed data which leads to this result
> when running 'ip -details link show can0':
>
> 35: can0: <NOARP,ECHO> mtu 16 qdisc noop state DOWN mode DEFAULT group default qlen 10
>      link/can  promiscuity 0
>      can state STOPPED restart-ms 0
> 	  pcan_usb: tseg1 1..16 tseg2 1..8 sjw 1..4 brp 1..64 brp-inc 1
> 	  : dtseg1 0..0 dtseg2 0..0 dsjw 1..0 dbrp 0..0 dbrp-inc 0  <== BROKEN!
> 	  clock 8000000
>
> This patch sets the dev_set_data_bittiming in struct peak_adapter to NULL to
> be able to disable the CAN FD specific information on non-FD adapters.
>
> This patch changes the struct peak_usb_adapter::bittiming_const and struct
> peak_usb_adapter::data_bittiming_const to pointers to fix the assignemnt
> problems.

I assumed there is an even better solution for the issue.
Thanks for the rework!

>
> Cc: linux-stable <stable@vger.kernel.org> # > 4.0

Should be:

Cc: linux-stable <stable@vger.kernel.org> # >= 4.0

> Reported-off-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tested-by: Oliver Hartkopp <socketcan@hartkopp.net>

At least with PCAN USB and PCAN USB FD - my 'pro' adapters are at the office.
But I can see no reason why they should not work in the same manner.

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
>
> picking up Olvier's work. Alternate approach, I've made the
> peak_usb_adapter::bittiming_const and struct
> peak_usb_adapter::data_bittiming_const a pointer.
>
> Please test,

done :-)

Best regards,
Oliver

