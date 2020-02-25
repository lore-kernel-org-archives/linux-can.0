From: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH linux-master 1/3] can: tcan4x5x: Move clock init to TCAN
 driver
Date: Tue, 25 Feb 2020 11:45:45 -0600
Message-ID: <e420c667-23d8-9739-1905-4a89570ddb72@ti.com>
References: <20200131183433.11041-1-dmurphy@ti.com>
 <20200131183433.11041-2-dmurphy@ti.com>
 <06af6e1d-aec4-189c-378a-77af4073a1a6@ti.com>
 <fed1d801-e284-eada-d5b3-ae78089b3ead@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33984 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731425AbgBYT3C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 25 Feb 2020 14:29:02 -0500
In-Reply-To: <fed1d801-e284-eada-d5b3-ae78089b3ead@pengutronix.de>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, wg@grandegger.com, sriram.dash@samsung.com
Cc: davem@davemloft.net

Marc

On 2/21/20 8:43 AM, Marc Kleine-Budde wrote:
> On 2/21/20 3:25 PM, Dan Murphy wrote:
>> Hello
>>
>> On 1/31/20 12:34 PM, Dan Murphy wrote:
>>> Move the clock discovery and initialization from the m_can framework to
>>> the registrar.  This allows for registrars to have unique clock
>>> initialization.  The TCAN device only needs the CAN clock reference.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>> I would like to have these 3 patches reviewed and integrated (post
>> review) so I can work on other issues identified.
> Applied to linux-can-next/testing.

I am not seeing these patches applied

I am looking here 
https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/log/?h=testing

But they could be in a different repo

Dan

>
> tnx,
> Marc
>
