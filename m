From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH] c_can: Add support for eg20t (pch_can)
Date: Tue, 08 Apr 2014 09:18:51 +0200
Message-ID: <1973262.duOsuUUePM@ws-stein>
References: <1396534451-9654-1-git-send-email-alexander.stein@systec-electronic.com> <1963054.jznjb2yEgj@ws-stein> <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:38114 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754698AbaDHHUE (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Apr 2014 03:20:04 -0400
In-Reply-To: <alpine.DEB.2.02.1404071816100.14882@ionos.tec.linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

On Monday 07 April 2014 18:27:11, Thomas Gleixner wrote:
>  static int c_can_read_objects(struct net_device *dev, struct c_can_priv *priv,
>  			      u32 pend, int quota)
>  {
> -	u32 pkts = 0, ctrl, obj, mcmd;
> +	u32 pkts = 0, ctrl, obj;
>  
>  	while ((obj = ffs(pend)) && quota > 0) {
>  		pend &= ~BIT(obj - 1);
>  
> -		mcmd = obj < C_CAN_MSG_RX_LOW_LAST ?
> -			IF_COMM_RCV_LOW : IF_COMM_RCV_HIGH;
> -
> -		c_can_object_get(dev, IF_RX, obj, mcmd);
> +		c_can_rx_object_get(dev, obj);
>  		ctrl = priv->read_reg(priv, C_CAN_IFACE(MSGCTRL_REG, IF_RX));
>  
>  		if (ctrl & IF_MCONT_MSGLST) {
> @@ -820,21 +841,25 @@ static int c_can_read_objects(struct net
>  		/* read the data from the message object */
>  		c_can_read_msg_object(dev, IF_RX, ctrl);
>  
> -		if (obj < C_CAN_MSG_RX_LOW_LAST)
> -			priv->rxmasked |= BIT(obj - 1);
> -		else if (obj == C_CAN_MSG_RX_LOW_LAST) {
> -			priv->rxmasked = 0;
> -			/* activate all lower message objects */
> -			c_can_activate_all_lower_rx_msg_obj(dev, IF_RX);
> -		}
> +		c_can_rx_finalize(dev, priv, obj);
>  
>  		pkts++;
>  		quota--;
> -	} while ((obj = ffs(pend)) && quota > 0);
> +	}
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

BTW: This doesn't look right.

Regards,
Alexander
-- 
Dipl.-Inf. Alexander Stein

SYS TEC electronic GmbH
Am Windrad 2
08468 Heinsdorfergrund
Tel.: 03765 38600-1156
Fax: 03765 38600-4100
Email: alexander.stein@systec-electronic.com
Website: www.systec-electronic.com
 
Managing Director: Dipl.-Phys. Siegmar Schmidt
Commercial registry: Amtsgericht Chemnitz, HRB 28082

