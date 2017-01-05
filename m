From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: mcba_usb: Add support for Microchip CAN BUS
 Analyzer.
Date: Thu, 5 Jan 2017 14:38:37 +0100
Message-ID: <1b3ead6a-b850-e232-511e-0e6a411588fc@hartkopp.net>
References: <20161104080357.780-1-remigiusz.kollataj@mobica.com>
 <CAKT-o-c8vxCtmQnc+erAZ1fKr7++cMj0hLFhNTkj6Q92aph-oQ@mail.gmail.com>
 <31c2110b-f12c-b089-5595-645b16c8095f@hartkopp.net>
 <CAKT-o-fuiFvhGxRHmFptfAj2dUmy36LQR0KWhZ_u3x48p8vS1g@mail.gmail.com>
 <6ceeaef3-488c-474d-6a94-2b8582c1916a@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:12458 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936025AbdAENj2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 5 Jan 2017 08:39:28 -0500
In-Reply-To: <6ceeaef3-488c-474d-6a94-2b8582c1916a@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, =?UTF-8?B?S2/FgsWCxIV0YWosIFJlbWlnaXVzeg==?= <remigiusz.kollataj@mobica.com>
Cc: linux-can@vger.kernel.org

On 01/05/2017 01:07 PM, Marc Kleine-Budde wrote:
> On 12/21/2016 06:18 PM, Kołłątaj, Remigiusz wrote:
>> On 20 December 2016 at 19:34, Oliver Hartkopp <socketcan@hartkopp.net> wrote:

>>> agreed on a common netlink interface to configure the termination.
>>
>> Can we keep sysfs setting for now? I will update the driver once
>> netlink API will be available. I will share my thoughts about the
>> interfaces in the email thread you have mentioned.
>
> No - better first add the driver without the a sysfs interfaces. Once
> the netlink interface is merged, this feature can be added to the driver.

Good idea to bring the driver into mainline faster.

The termination should be set to disabled by default.

Regards,
Oliver
