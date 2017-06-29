From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: Re: MCAN Registers Discrepancy
Date: Thu, 29 Jun 2017 13:19:23 -0500
Message-ID: <3bb683f9-a54a-b005-29f6-5dde8b56f245@ti.com>
References: <62a65051-a8f4-0bd9-238c-0e28814e4249@ti.com>
 <91fc83e9-3669-576c-f7ba-285afb30da5a@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from fllnx210.ext.ti.com ([198.47.19.17]:43076 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdF2STb (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 29 Jun 2017 14:19:31 -0400
In-Reply-To: <91fc83e9-3669-576c-f7ba-285afb30da5a@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, "Huettel Mario (AE/PJ-SCI1)" <Mario.Huettel@de.bosch.com>

Hi Oliver,

On 06/29/2017 12:38 PM, Oliver Hartkopp wrote:
> Hi Franklin,
> 
> I added Mario in CC as he provided the latest updates to the M_CAN
> driver and the multi IP revision support.
> 
> As you are not the first one asking for the 'older' M_CAN IP revision
> user manuals I uploaded my formerly downloaded manuals here:
> 
> https://github.com/hartkopp/M_CAN-User-Manual-History

It seems I missed Mario's changes since he fixed the problem I
mentioned. But thanks for sharing these documents. It helps alot.
> 
> Best regards,
> Oliver
> 
> On 06/28/2017 11:49 PM, Franklin S Cooper Jr wrote:
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
>>
>>
