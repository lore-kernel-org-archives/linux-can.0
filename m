From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Sun, 26 Nov 2017 20:05:37 +0100
Message-ID: <3b1c4778-b155-7aaf-e5b4-14061e687161@grandegger.com>
References: <20171124183509.12810-1-kernel@martin.sperl.org>
 <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net>
 <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org>
 <0c2f4a35-3b86-7ae6-ccc6-2751fa92f497@grandegger.com>
 <CEE8AB99-2B26-44C0-A8D1-DD339DC9FEF7@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.67]:58002 "EHLO
        mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdKZTFk (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Nov 2017 14:05:40 -0500
In-Reply-To: <CEE8AB99-2B26-44C0-A8D1-DD339DC9FEF7@martin.sperl.org>
Content-Language: en-GB
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kernel@martin.sperl.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org


Am 26.11.2017 um 19:29 schrieb kernel@martin.sperl.org:
> 
>> On 26.11.2017, at 17:18, Wolfgang Grandegger <wg@grandegger.com> wrote:
>>
>> Hello Martin,
>>
>> Am 25.11.2017 um 15:47 schrieb kernel@martin.sperl.org:
>>
>> ...snip...
>>> I see the following counters:
>>> 7: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNKNOWN mode DEFAULT group default qlen 10
>>>      link/can  promiscuity 0
>>>      can <ONE-SHOT,BERR-REPORTING> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 0
>>
>> Why do you use "ONE_SHOT" in all your test cases?
> I did test oneshot and non-oneshot - I just did not document them
> here, I am just mentioning the issue of dropped frames when the driver
> is submitting them correctly.
> 
> Also - for what it is worse - the RX case would not be impacted by one-shot
> enabled or not.
> 
> 
>> Did you also check for out-of-order issues, e.g. by using "canfdtest”?
> 
> As for out of order: yes I have taken extreme care that we do not
> get out of order packets for all possible cases testing with cangen - there
> may be one error case where there could be an out of order case in the
> tx path (unless we want to drop that frame - it would be a MAB case)
> 
> But until now I did not know about canfdtest, but for all practical
> purposes it can not test for out-of-order delivery on a 100% saturated
> bus the way it is working - latencies are too big for that!
> 
> Still for completeness a quick test from beagleboneblack to a
> RPI CM3 with a mcp2517fd gives:
> root@beaglebone:~/can-utils# ./canfdtest -g -vvv can0 -l 32
> interface = can0, family = 29, type = 3, proto = 1
> 0078: [8] 01 02 03 04 05 06 07 08
> 0078: [8] 02 03 04 05 06 07 08 09
> 0078: [8] 03 04 05 06 07 08 09 0a
> 0078: [8] 04 05 06 07 08 09 0a 0b
> 0078: [8] 05 06 07 08 09 0a 0b 0c
> 0078: [8] 06 07 08 09 0a 0b 0c 0d
> 0078: [8] 07 08 09 0a 0b 0c 0d 0e
> 0078: [8] 08 09 0a 0b 0c 0d 0e 0f
> 0078: [8] 09 0a 0b 0c 0d 0e 0f 10
> 0078: [8] 0a 0b 0c 0d 0e 0f 10 11
> 0078: [8] 0b 0c 0d 0e 0f 10 11 12
> 0078: [8] 0c 0d 0e 0f 10 11 12 13
> 0078: [8] 0d 0e 0f 10 11 12 13 14
> 0078: [8] 0e 0f 10 11 12 13 14 15
> 0078: [8] 0f 10 11 12 13 14 15 16
> 0078: [8] 10 11 12 13 14 15 16 17
> 0078: [8] 11 12 13 14 15 16 17 18
> 0078: [8] 12 13 14 15 16 17 18 19
> 0078: [8] 13 14 15 16 17 18 19 1a
> 0078: [8] 14 15 16 17 18 19 1a 1b
> 0078: [8] 15 16 17 18 19 1a 1b 1c
> 0078: [8] 16 17 18 19 1a 1b 1c 1d
> 0078: [8] 17 18 19 1a 1b 1c 1d 1e
> 0078: [8] 18 19 1a 1b 1c 1d 1e 1f
> 0078: [8] 19 1a 1b 1c 1d 1e 1f 20
> 0078: [8] 1a 1b 1c 1d 1e 1f 20 21
> 0078: [8] 1b 1c 1d 1e 1f 20 21 22
> 0078: [8] 1c 1d 1e 1f 20 21 22 23
> 0078: [8] 1d 1e 1f 20 21 22 23 24
> 0078: [8] 1e 1f 20 21 22 23 24 25
> 0078: [8] 1f 20 21 22 23 24 25 26
> 0078: [8] 20 21 22 23 24 25 26 27
> 
> Test messages sent and received: 32
> 
> (I can not go to longer tests because I may hit a bug I am just
> now trying to fix in the current code level).

This test does not load the bus a lot but uses burst of message to 
trigger out-of-order issues. Please run the test without "-v" and much 
longer.

> If you are interested in any more specific tests that I should
>   be running, then please list those and I can report them
> when submitting V2 of the patch set.

Other useful test are about bus error reporting and error state changes.

Can bus errors been disabled via interrupt? I do not see that 
CAN_CTRLMODE_BERR_REPORTING is handled. This means that bus error 
reporting is always on which may put heavy load on the system. e.g if no 
cable is connected and a message sent (at 1MB/s).

Concerning the error state changes, have a look to [1].

> Just to put everything into perspective:
> The equipment available to me is:
> * beagle bone black with c_can
> * raspberry pi 3 with mcp2515
> * raspberry pi CM3 with mcp2517fd
> * raspberry pi 2 with mcp2517fd
> * saleae logic analyzer

[1] https://marc.info/?l=linux-can&m=151147114323582&w=2

The driver has more than 3000 lines... a review will take some time.

Thanks for your contribution.

Wolfgang.
> 
> Thanks,
> 	Martin--
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
