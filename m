From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: VCAN and CAN-FD DLC versus data length
Date: Mon, 20 Jan 2020 07:58:19 +0100
Message-ID: <d7acf517-d6dc-41d5-b49b-7ecebb10c627@gmail.com>
References: <ec6ffa3c-b208-b76a-d1ac-afd2fb1182a7@gmail.com>
 <444ec681-0591-daf2-84ac-feed5c18ecf9@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33378 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATG6X (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 20 Jan 2020 01:58:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id d139so14050594wmd.0
        for <linux-can@vger.kernel.org>; Sun, 19 Jan 2020 22:58:22 -0800 (PST)
In-Reply-To: <444ec681-0591-daf2-84ac-feed5c18ecf9@hartkopp.net>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

Am 17.01.20 um 16:06 schrieb Oliver Hartkopp:
> Hi Andre,
> 
> On 17/01/2020 14.26, Andre Naujoks wrote:
> 
>> If I send a CAN-FD frame with a length, which is not directly 
>> representable by the DLC field, the vcan driver conserves this value. 
>> E.g. a Length of 11 is sent and received in userspace, even though 
>> there is no DLC representation for 11.
>>
>> I talked to a colleague about this and we could not think of a case, 
>> in which this behaviour presents a problem. It is just a small 
>> discrepancy from how a real CAN would behave.
> 
> Right.
> 
> Last time when we changed the can-gw we had a discussion about this 
> "sanitizing" of CAN specific data length here:
> 
> https://marc.info/?l=linux-can&m=156537620228658

Thanks for the link!

> 
> 1. When we get a CAN skb from the real CAN interface this is correct (in 
> CAN length)
> 
> 2. When we send stuff to the real CAN interface the value is fixed 
> before writing the content into the CAN controllers registers.
> 
>> cansend from the can-utils package actually makes sure not to use a 
>> data length, which is not directly representable. This is the output 
>> of a candump oagainst a patched version, which does not "fix" the length.
>>
>> $ candump any & ./patched-cansend vcan0 123##011223344556677889900AA
>>    vcan0  123  [11]  11 22 33 44 55 66 77 88 99 00 AA
> 
> Yes. vcan is just forwarding frames without sanitizing. And even the 
> can-gw can be used to (intentionally) create weird values in the length 
> field - but makes sure that the length boundaries of CAN (0 .. 8) and 
> CAN FD (0 .. 64) are met.
> 
> So using the len value e.g. in a for-statement never lets you write 
> outside the CAN(FD) frame data[].
> 
>> Does anyone have a real case, which would warrant a patch to the vcan 
>> driver to change this? Or should the CAN stack even return EINVAL on a 
>> data length, that is not representable?
> 
> As we had that discussion in the URL above and I can't see anything 
> breaking I would tend to leave it as-is.
> 
> When we would sanitize the vcan skb flow we might end up with many 
> skb_copy() cases instead of skb_clone() (permormance!). And as people 
> may create skbs with PF_PACKET we are also not able to fix-up the length 
> until it reaches the driver layer anyway.
> 
> Does that fit for you?

Yes, it makes sense. This was kind of what I was looking for: Somebody 
else, who thinks this is not an issue.

Thanks again for the detailed explanation! I think I will take care of 
the lengths in my application then. Just to have consistent behaviour on 
CAN vs VCAN. In the end it is a cosmetic issue.

Best Regars
   Andre

> 
> Best,
> Oliver
