From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH] can: flexcan: add 2nd clock to support imx53 and newer
Date: Wed, 18 Jul 2012 16:48:21 +0800
Message-ID: <50067855.60800@gmail.com>
References: <1342562748-24701-1-git-send-email-mkl@pengutronix.de> <50061B86.7080200@gmail.com> <500675C2.9090303@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:35228 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148Ab2GRIs7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 04:48:59 -0400
In-Reply-To: <500675C2.9090303@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, linux-can@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>

Marc Kleine-Budde wrote:
> On 07/18/2012 04:12 AM, Hui Wang wrote:
>   
>> Marc Kleine-Budde wrote:
>>     
>>> From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>>
>>> This patch add support for a second clock to the flexcan driver. On
>>> modern
>>> freescale ARM cores like the imx53 and imx6q two clocks ("ipg" and "per")
>>> must be enabled in order to access the CAN core.
>>>
>>> In the original driver, the clock was requested without specifying the
>>> connection id, further all mainline ARM archs with flexcan support
>>> (imx28, imx25, imx35) register their flexcan clock without a
>>> connection id,
>>> too.
>>>
>>> This patch first renames the existing clk variable to clk_ipg and adds
>>> the
>>> connection id "ipg" to the clk_get() call. Then a second clock "per" is
>>> requested. As all archs don't specify a connection id, both clk_get
>>> return
>>> the same clock. This ensures compatibility to existing flexcan support
>>> and adds support for imx53 at the same time.
>>>
>>> After this patch hits mainline, the archs may give their existing flexcan
>>> clock the "ipg" connection id and implement a dummy "per" clock.
>>>
>>> This patch has been tested on imx28 (unmodified clk tree) and on imx53
>>> with a seperate "ipg" and "per" clock.
>>>
>>> Cc: Sascha Hauer <s.hauer@pengutronix.de>
>>> Cc: Shawn Guo <shawn.guo@linaro.org>
>>> Cc: Hui Wang <jason77.wang@gmail.com>
>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> ---
>>>  drivers/net/can/flexcan.c |   52
>>> ++++++++++++++++++++++++++++++---------------
>>>  1 file changed, 35 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index c8a6fc7..281d51f 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -190,7 +190,8 @@ struct flexcan_priv {
>>>
>>>   
>>>       
>> [...]
>>     
>>>      if (!clock_freq) {
>>> -        clk = clk_get(&pdev->dev, NULL);
>>> -        if (IS_ERR(clk)) {
>>> -            dev_err(&pdev->dev, "no clock defined\n");
>>> -            err = PTR_ERR(clk);
>>> +        clk_ipg = clk_get(&pdev->dev, "ipg");
>>> +        if (IS_ERR(clk_ipg)) {
>>> +            dev_err(&pdev->dev, "no ipg clock defined\n");
>>> +            err = PTR_ERR(clk_ipg);
>>> +            goto failed_clock;
>>> +        }
>>> +        clock_freq = clk_get_rate(clk_ipg);
>>> +
>>> +        clk_per = clk_get(&pdev->dev, "per");
>>> +        if (IS_ERR(clk_per)) {
>>> +            dev_err(&pdev->dev, "no per clock defined\n");
>>> +            err = PTR_ERR(clk_per);
>>>              goto failed_clock;
>>>          }
>>>   
>>>       
>> For those only register one clk and without con_id (mx35), clk_per will
>> equal to clk_ipg, how to handle this situation, modify mx35 clk tree?
>>     
>
> This isn't a problem, the clock is just enabled twice. As soon as this
> patch is mainline the clock tree on the one-clock-for-flexcan archs can
> modify their clock tree. I've commented on this in the commit message,
> have you read it?
>   
Got it now. :-)

