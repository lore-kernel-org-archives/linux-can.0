From: Amit Virdi <amit.virdi@st.com>
Subject: Re: [PATCH 3/3] can: c_can: Enable clock before first use
Date: Wed, 16 Jan 2013 13:33:27 +0530
Message-ID: <50F65ECF.6070802@st.com>
References: <cover.1355996839.git.amit.virdi@st.com> <3ce526df6a4f9e71f8b05132689db7426bae6bbb.1355996839.git.amit.virdi@st.com> <50D31B96.8010501@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:57666 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757708Ab3APIDr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 16 Jan 2013 03:03:47 -0500
In-Reply-To: <50D31B96.8010501@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "wg@grandegger.com" <wg@grandegger.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, "anilkumar@ti.com" <anilkumar@ti.com>, spear-devel <spear-devel@list.st.com>

On 12/20/2012 7:37 PM, Marc Kleine-Budde wrote:
> On 12/20/2012 11:05 AM, Amit Virdi wrote:
>> Current implementation assumes clock to be always enabled. Instead,
>> explicitly enable device clock before usage.
>>
>> Signed-off-by: Amit Virdi<amit.virdi@st.com>
>> Reviewed-by: Shiraz Hashim<shiraz.hashim@st.com>
>> ---
>>   drivers/net/can/c_can/c_can_platform.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
>> index 6e8dc56..d0bd6e6 100644
>> --- a/drivers/net/can/c_can/c_can_platform.c
>> +++ b/drivers/net/can/c_can/c_can_platform.c
>> @@ -194,6 +194,12 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
>>   		goto exit;
>>   	}
>>
>> +	ret = clk_prepare_enable(clk);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "could not prepare CAN clock\n");
>> +		goto exit_no_clk_en;
>> +	}
>> +
>>   	/* get the platform data */
>>   	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>   	irq = platform_get_irq(pdev, 0);
>> @@ -295,6 +301,8 @@ exit_iounmap:
>>   exit_release_mem:
>>   	release_mem_region(mem->start, resource_size(mem));
>>   exit_free_clk:
>> +	clk_disable_unprepare(clk);
>> +exit_no_clk_en:
>>   	clk_put(clk);
>>   exit:
>>   	dev_err(&pdev->dev, "probe failed\n");
>
> Why do you have to enable the clock if the driver is loaded? What about
> disabling the clock on driver unload. The clock should be enabled on
> open and disabled on close if the network interface. If you need to
> access the registers of your hardware, you should enable the clock
> before accessing the regs and disable the clock when finished.
>

Okay, I would take care of it in V2.

Regards
Amit Virdi
