From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: Re: MCAN Registers Discrepancy
Date: Thu, 29 Jun 2017 10:13:18 -0500
Message-ID: <6790157e-55c0-597a-6ac9-626c17e9ff66@ti.com>
References: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>
 <b640c93b-23fe-82dc-b0ec-5c77fea64ed7@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelnx193.ext.ti.com ([198.47.27.77]:30571 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdF2PNj (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jun 2017 11:13:39 -0400
In-Reply-To: <b640c93b-23fe-82dc-b0ec-5c77fea64ed7@gmx.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?Q?Mario_H=c3=bcttel?= <mario.huettel@gmx.net>, linux-can@vger.kernel.org, wg@grandegger.com, mkl@pengutronix.de, b29396@freescale.com, socketcan@hartkopp.net

Hi Mario,

On 06/29/2017 09:52 AM, Mario Hüttel wrote:
> Hello,
> 
> you are right. There are/were some incosistencies in the values.
> 
> However, the driver used them correctly. The driver version you
> 
> talk about is not entirely compatible with the user manual you provided.
> 
> 
> I wrote some patches back in April which add support for the newer M_CAN
> 
> versions up to 3.2.X:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/can/m_can
> 
> These should work as intended.
> 
> Before, the driver could only handle IP versions 3.0.X.

It was my mistake. Looks like the branch I was working off of wasn't
updated for a bit. Your patches contain exactly what I found was needed.

> 
> 
> Mario
> 
> 
> 
> On 06/28/2017 11:49 PM, Franklin S Cooper Jr wrote:
>> Hi,
>>
>> When looking at the latest versions of the MCAN user manual it seems
>> that there is a discrepancy between the various BTR_XX_MASK and
>> BTR_XX_SHIFT values. For example BTR_TSEG2_MASK is set to 0xF and
>> BTR_TSEG2_SHIFT is 4. However, based on page 21 of the latest version of
>> the MCAN User Manual NTSEG2 starts at bit 0. Therefore, it should have a
>> shift value of 0. Also it is a 7 bit field so its mask should be 0x7F. I
>> see similar issues with FBTR_XXX_MASK values.
>>
>> So the original driver mentioned it was based on rev version 3.1.0 of
>> the User Manual while the latest version publicly available is 3.2.12.
>> Since I don't see any current users of this driver in upstream I am
>> unsure if this is just a bug in the code or if the current values are
>> correct for older versions of the IP.
>>
>> Does anyone have a copy of this older document available that they can
>> share? Or at the very least verify that the current values were correct
>> in older revisions of the MCAN IP? I need to make updates to the drivers
>> but I want to avoid breaking things for other people.
>>
>> Latest version of the MCAN User Manual can be found at:
>> http://www.bosch-semiconductors.de/media/automotive_electronics/pdf_2/ipmodules_3/m_can_m_ttcan_1/mcan_users_manual_v3212.pdf
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-can" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
