From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer.
Date: Thu, 5 Jan 2017 14:36:55 +0100
Message-ID: <e7f1511b-02ae-f5c1-4986-0e540df3d9fd@hartkopp.net>
References: <20161104080357.780-1-remigiusz.kollataj@mobica.com>
 <dde2aebd-904a-234c-1437-116973201211@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:25200 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935113AbdAENhG (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 08:37:06 -0500
In-Reply-To: <dde2aebd-904a-234c-1437-116973201211@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Remigiusz Kollataj <remigiusz.kollataj@mobica.com>, linux-can@vger.kernel.org

On 01/05/2017 12:55 PM, Marc Kleine-Budde wrote:
> On 11/04/2016 09:03 AM, Remigiusz Kollataj wrote:

>> +	if (MCBA_RX_IS_RTR(msg))
>> +		cf->can_id |= MCBA_CAN_RTR_MASK;
>> +
>> +	cf->can_dlc = msg->dlc & MCBA_DLC_MASK;
>
> Please check, that the dlc stays <= 8 bytes. As this is a USB device,
> this value cannot be trusted.

Yes.

Please use the existing helper function:

	cf->can_dlc = get_can_dlc(msg->dlc & MCBA_DLC_MASK);

Regards,
Oliver

