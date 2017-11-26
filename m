From: kernel@martin.sperl.org
Subject: Re: [PATCH 0/2] Microchip mcp2517fd can controller driver
Date: Sun, 26 Nov 2017 20:53:20 +0100
Message-ID: <625AAD8B-80D4-46AF-8E00-7C9C0F10DE4F@martin.sperl.org>
References: <20171124183509.12810-1-kernel@martin.sperl.org> <3d355c51-09a3-40b8-46bf-8437e26a95f3@hartkopp.net> <263BAF25-3F9A-4BE8-8E19-757B3C22A037@martin.sperl.org> <0c2f4a35-3b86-7ae6-ccc6-2751fa92f497@grandegger.com> <CEE8AB99-2B26-44C0-A8D1-DD339DC9FEF7@martin.sperl.org> <3b1c4778-b155-7aaf-e5b4-14061e687161@grandegger.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:41566
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdKZTxT (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 26 Nov 2017 14:53:19 -0500
In-Reply-To: <3b1c4778-b155-7aaf-e5b4-14061e687161@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, devicetree@vger.kernel.org

Hi Wolfgang!

> On 26.11.2017, at 20:05, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Test messages sent and received: 32
>> (I can not go to longer tests because I may hit a bug I am just
>> now trying to fix in the current code level).
> 
> This test does not load the bus a lot but uses burst of message to trigger out-of-order issues. Please run the test without "-v" and much longer.

I agree, but as mentioned: I am debugging something else, which makes the
system slightly unstable, so I refrained from running longer tests...


>> If you are interested in any more specific tests that I should
>>  be running, then please list those and I can report them
>> when submitting V2 of the patch set.
> 
> Other useful test are about bus error reporting and error state changes.
> 
> Can bus errors been disabled via interrupt? I do not see that CAN_CTRLMODE_BERR_REPORTING is handled. This means that bus error reporting is always on which may put heavy load on the system. e.g if no cable is connected and a message sent (at 1MB/s).
> 
> Concerning the error state changes, have a look to [1].

Yes - it comes with the 9 (32-bit) register read on every interrupt.
This is actually an optimization to avoid kernel latencies that would 
occur when reading 3 sets of registers separately.
Also longer reads means a higher likleyhood that DMA will be used
by the spi-controller/driver.

> 
>> Just to put everything into perspective:
>> The equipment available to me is:
>> * beagle bone black with c_can
>> * raspberry pi 3 with mcp2515
>> * raspberry pi CM3 with mcp2517fd
>> * raspberry pi 2 with mcp2517fd
>> * saleae logic analyzer
> 
> [1] https://marc.info/?l=linux-can&m=151147114323582&w=2
> 
I will try to run those and add them to the cover page for V2.


> The driver has more than 3000 lines... a review will take some time.

Please look mostly at the device-tree and the main comments about the
rationale and performance optimizations at first.

Feedback on these I could include with V2 of the patch that will
fix also the above mentioned errors and MAB avoidance code.
I should be able to post it later this week.

Thanks,
		Martin