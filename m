From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v10 1/7] Add CAN FD infrastructure for CAN driver
Date: Tue, 04 Mar 2014 22:22:28 +0100
Message-ID: <53164414.2070903@hartkopp.net>
References: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:56531 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755840AbaCDVWb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Mar 2014 16:22:31 -0500
In-Reply-To: <1393965855-3408-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: kernel@pengutronix.de



On 04.03.2014 21:44, Marc Kleine-Budde wrote:
> Picking up Oliver's patches.
> 
> I've added Stephane's Acked-by to all patches.
> 
> Changes since v9:
> - 3/7 + 4/7
>   I moved the simplified "if" in can_get_bittiming() from 4/7 into 3/7,
>   so the more complicated if is not introduced in the first place.

ok.

> - 5/7
>   In can_changelink(), when setting the data bittining, I removed the call to
>   priv->do_set_data_bittiming().

I think the call to priv->do_set_data_bittiming() has to remain here to be
consistent to priv->do_set_bittiming() in the same function.

When priv->do_set_[data_]bittiming() is to be removed in the future it should
be removed for both functions in the same way to prevent confusion.

>   Further I moved the new "if (data[IFLA_CAN_DATA_BITTIMING])" at the bottom,
>   so that all "if"s are sorted by "IFLA_".

?? You are moving the "if (data[IFLA_CAN_DATA_BITTIMING])" here and then you
move it in 6/7 again. %-)


> - 6/7
>   can_change_mtu(): fix indention after "default" in "switch"

ok.

Tnx,
Oliver

