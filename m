From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can/peak_usb: mark current PEAK USB FD as non-ISO
Date: Tue, 27 Jan 2015 19:10:16 +0100
Message-ID: <54C7D488.4010203@hartkopp.net>
References: <1422381484-3804-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:45959 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932467AbbA0SKc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 27 Jan 2015 13:10:32 -0500
In-Reply-To: <1422381484-3804-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

Hello Marc,

your v10 series looks very good. The ARRAY_SIZE stuff is a good improvement!

I compiled the peak-next branch and inserting my single PCAN USB FD adapter 
worked fine. I'll send my tested-by when I can access my second adapter at 
work tomorrow.

The  patch below finally sets the CAN_CTRLMODE_FD_NON_ISO flag.
It's tested with the updated ip tool.

But beware: The current linux-can-next is missing the CAN_CTRLMODE_FD_NON_ISO 
patch for M_CAN. Therefore CAN_CTRLMODE_FD_NON_ISO is not defined until Dave 
pulled net into net-next. So this patch creates a compile error in the latest 
linux-can-next.

Regards,
Oliver

On 27.01.2015 18:58, Oliver Hartkopp wrote:
> The current PCAN USB FD (pro) adapters support the non-ISO CAN FD protocol.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> ---
>   drivers/net/can/usb/peak_usb/pcan_usb_fd.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> index e4d9354..962c3f0 100644
> --- a/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> +++ b/drivers/net/can/usb/peak_usb/pcan_usb_fd.c
> @@ -860,6 +860,9 @@ static int pcan_usb_fd_init(struct peak_usb_device *dev)
>   			 pdev->usb_if->fw_info.fw_version[2],
>   			 dev->adapter->ctrl_count);
>
> +		/* the currently supported hw is non-ISO */
> +		dev->can.ctrlmode = CAN_CTRLMODE_FD_NON_ISO;
> +
>   		/* tell the hardware the can driver is running */
>   		err = pcan_usb_fd_drv_loaded(dev, 1);
>   		if (err) {
>
