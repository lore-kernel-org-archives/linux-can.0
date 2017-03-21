From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH 2/3] can: m_can: Enable M_CAN IP version dependent
 initialization
Date: Tue, 21 Mar 2017 20:26:31 +0100
Message-ID: <5d257446-974a-7a63-c80d-6df4209906aa@hartkopp.net>
References: <1489154417-19669-1-git-send-email-mario.huettel@de.bosch.com>
 <1489154417-19669-4-git-send-email-mario.huettel@de.bosch.com>
 <373beaf7-5c07-0b07-e261-f2b74d1ee088@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p04-ob.smtp.rzone.de ([81.169.146.179]:29834 "EHLO
        mo4-p04-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933646AbdCUT1M (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 21 Mar 2017 15:27:12 -0400
In-Reply-To: <373beaf7-5c07-0b07-e261-f2b74d1ee088@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Mario Huettel <mario.huettel@de.bosch.com>, linux-can@vger.kernel.org

On 03/21/2017 03:33 PM, Marc Kleine-Budde wrote:

>> +enum m_can_versions {
>> +	M_CAN_UNKNOWN_VERSION = 0,
>> +	M_CAN_V30X,
>> +	M_CAN_V31X,
>> +	M_CAN_V32X
>> +};
>
> Please use a common naming scheme here:
>
> enum m_can_version {
> 	M_CAN_VERSION_UNKNOWN,
> 	M_CAN_VERSION_30X,
> 	M_CAN_VERSION_31X,
> 	...,
> };

Your should review the v2 patches %-)

Regards,
Oliver
