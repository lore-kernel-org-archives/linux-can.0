From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH V2 2/4] net: can: ifi: Fix TX DLC configuration
Date: Wed, 2 Mar 2016 19:46:51 +0100
Message-ID: <56D7351B.1060403@hartkopp.net>
References: <1456915359-6775-1-git-send-email-marex@denx.de>
 <1456915359-6775-3-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:53460 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753109AbcCBSrI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 Mar 2016 13:47:08 -0500
In-Reply-To: <1456915359-6775-3-git-send-email-marex@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>, linux-can@vger.kernel.org
Cc: netdev@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Wolfgang Grandegger <wg@grandegger.com>

Hi Marek,

sorry for picking this patch up again.

After looking around in the original source I have one more comment:

On 03/02/2016 11:42 AM, Marek Vasut wrote:

> -	if (priv->can.ctrlmode & (CAN_CTRLMODE_FD | CAN_CTRLMODE_FD_NON_ISO)) {
> -		if (can_is_canfd_skb(skb)) {
> -			txdlc |= IFI_CANFD_TXFIFO_DLC_EDL;
> -			if (cf->flags & CANFD_BRS)
> -				txdlc |= IFI_CANFD_TXFIFO_DLC_BRS;
> -		}
> +	txdlc |= can_len2dlc(cf->len);

At the top of the function you defined

	u32 txst, txid;
	u32 txdlc = 0;

and here you use 'txdlc |= ...'.

That's weird style IMO.

Please change it to

	u32 txst, txid, txdlc;

and

	txdlc = can_len2dlc(cf->len);


Thanks,
Oliver

