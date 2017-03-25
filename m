From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v3 4/6] can: m_can: Enable M_CAN version dependent
 initialization
Date: Sat, 25 Mar 2017 17:10:43 +0100
Message-ID: <a98d0991-b0f7-48f9-c66f-f327df4b8925@hartkopp.net>
References: <1490374171-15190-1-git-send-email-mario.huettel@de.bosch.com>
 <1490374171-15190-4-git-send-email-mario.huettel@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:14691 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbdCYQLP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sat, 25 Mar 2017 12:11:15 -0400
In-Reply-To: <1490374171-15190-4-git-send-email-mario.huettel@de.bosch.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org


On 03/24/2017 05:49 PM, Mario Huettel wrote:

> @@ -928,29 +961,58 @@ static void m_can_chip_config(struct net_device *dev)
>  		     priv->mcfg[MRAM_RXF1].off);
>
>  	cccr = m_can_read(priv, M_CAN_CCCR);
> -	cccr &= ~(CCCR_TEST | CCCR_MON | (CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
> -		(CCCR_CME_MASK << CCCR_CME_SHIFT));
>  	test = m_can_read(priv, M_CAN_TEST);
>  	test &= ~TEST_LBCK;
> +	if (priv->version == 30) {
> +	/* Version 3.0.x */
>
> -	if (priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY)
> -		cccr |= CCCR_MON;
> +		cccr &= ~(CCCR_TEST | CCCR_MON |
> +			(CCCR_CMR_MASK << CCCR_CMR_SHIFT) |
> +			(CCCR_CME_MASK << CCCR_CME_SHIFT));
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +			cccr |= CCCR_CME_CANFD_BRS << CCCR_CME_SHIFT;
> +
> +	} else {
> +	/* Version 3.1.x or 3.2.x */
> +		cccr &= ~(CCCR_TEST | CCCR_MON | CCCR_BRSE | CCCR_FDOE);
> +
> +		/* Only 3.2.x has NISO Bit implemented */
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD_NON_ISO)
> +			cccr |= CCCR_NISO;
> +
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> +			cccr |= CCCR_TEST | CCCR_MON;
> +			test |= TEST_LBCK;
> +		}

This is code duplication which is repeated some line later ...
>
> +		if (priv->can.ctrlmode & CAN_CTRLMODE_FD)
> +			cccr |= (CCCR_BRSE | CCCR_FDOE);
> +	}
> +
> +	/* Loopback Mode */
>  	if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> -		cccr |= CCCR_TEST;
> +		cccr |= CCCR_TEST | CCCR_MON;
>  		test |= TEST_LBCK;
>  	}

here :-)

So the first appearance can be removed.

(..)

>
> +	/* Set properties depending on M_CAN version */
> +	switch (priv->version) {
> +	case 30:
> +		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.0.x */
> +		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> +		priv->can.bittiming_const = &m_can_bittiming_const_30X;
> +		priv->can.data_bittiming_const =
> +				&m_can_data_bittiming_const_30X;
> +		break;
> +	case 31:
> +		/* CAN_CTRLMODE_FD_NON_ISO is fixed with M_CAN IP v3.1.x */
> +		can_set_static_ctrlmode(dev, CAN_CTRLMODE_FD_NON_ISO);
> +		priv->can.bittiming_const = &m_can_bittiming_const_31X;
> +		priv->can.data_bittiming_const =
> +				&m_can_data_bittiming_const_31X;
> +		break;
> +	case 32:
> +		priv->can.bittiming_const = &m_can_bittiming_const_31X;
> +		priv->can.data_bittiming_const =
> +				&m_can_data_bittiming_const_31X;
> +		priv->can.ctrlmode_supported |= (m_can_niso_supported(priv)
> +						? CAN_CTRLMODE_FD_NON_ISO
> +						: 0);
> +		break;
> +	default:
> +		/* This does not happen */

No.

Think about an IP version 3.3.x read from the controller register.

When this default is triggered, the driver initialization should fail.

Regards,
Oliver

