From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 3/4] can: netlink: Add CAN_CTRLMODE_PRESUME_ACK flag
Date: Thu, 10 Jul 2014 10:06:47 -0400
Message-ID: <53BE9DF7.6020608@hartkopp.net>
References: <1404934273-19233-1-git-send-email-nebaruzdin@gmail.com> <1404934273-19233-3-git-send-email-nebaruzdin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:52863 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaGJOG6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Jul 2014 10:06:58 -0400
In-Reply-To: <1404934273-19233-3-git-send-email-nebaruzdin@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, wg@grandegger.com
Cc: Nikita Edward Baruzdin <nebaruzdin@gmail.com>, linux-can@vger.kernel.org

Hello Marc and Wolfgang,

what do you think about this extension.

 From my side the patchset makes sense.

Regards,
Oliver

On 09.07.2014 15:31, Nikita Edward Baruzdin wrote:
> Most CAN controllers have a support for ignoring ACK absence. Some of
> them refer to this feature as a self test mode (e. g. SJA1000) and some
> include it as a part of a loopback mode (e. g. MCP2510).
>
> Setting the introduced flag via netlink should make CAN controller
> perform a successful transmission, even if there is no acknowledgement
> (dominant ACK bit) received.
>
> Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@gmail.com>
> ---
>   include/uapi/linux/can/netlink.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
> index 3bbf5c7..3e4323a 100644
> --- a/include/uapi/linux/can/netlink.h
> +++ b/include/uapi/linux/can/netlink.h
> @@ -97,6 +97,7 @@ struct can_ctrlmode {
>   #define CAN_CTRLMODE_ONE_SHOT		0x08	/* One-Shot mode */
>   #define CAN_CTRLMODE_BERR_REPORTING	0x10	/* Bus-error reporting */
>   #define CAN_CTRLMODE_FD			0x20	/* CAN FD mode */
> +#define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
>
>   /*
>    * CAN device statistics
>
