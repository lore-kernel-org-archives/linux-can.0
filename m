From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 4/5][RFC] can: kline: Add KLine rtnl configuration options
Date: Sat, 11 Jun 2016 21:40:24 +0200
Message-ID: <575C6928.80302@denx.de>
References: <1465500064-5402-1-git-send-email-marex@denx.de> <1465500064-5402-4-git-send-email-marex@denx.de> <5759CFCD.1050305@posteo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:53623 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752162AbcFKTs1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 11 Jun 2016 15:48:27 -0400
In-Reply-To: <5759CFCD.1050305@posteo.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Menschel.P" <menschel.p@posteo.de>, linux-can@vger.kernel.org

On 06/09/2016 10:21 PM, Menschel.P wrote:
> Hello Marek,

Hi,

> these look like the timing parameters for KWP2000 protocol.
>> +struct kline_timing {
>> +    __u32 w0;
>> +    __u32 w1;
>> +    __u32 w2;
>> +    __u32 w3;
>> +    __u32 w4;
>> +    __u32 w5;
>> +    __u32 p1;
>> +    __u32 p2_94;
>> +    __u32 p2_08;
>> +    __u32 p3;
>> +    __u32 p4;
>> +};
> The wX parameters are the wake up timings and the pX are the response
> timings in between tester and ecu.
> Imho the protocol needs to be separated from the device driver since
> there are other protocols like kwp500 and kwp1281 that use k-line.

Do you have some idea how to design the framework ?

-- 
Best regards,
Marek Vasut
