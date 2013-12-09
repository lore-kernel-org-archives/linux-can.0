From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: GS_USB
Date: Mon, 09 Dec 2013 14:15:39 +0100
Message-ID: <52A5C27B.1030804@grandegger.com>
References: <1380889887.22484.2.camel@blackbox>	 <52507832.8000709@grandegger.com> <1381155720.21207.7.camel@blackbox>	 <5e3f6029b128db63c69664deed10c5d6@grandegger.com>	 <1381175546.21207.37.camel@blackbox> <525319E6.4020505@grandegger.com>	 <1383498724.4208.4.camel@blackbox> <527EC310.5010003@grandegger.com>	 <1384135835.3749.31.camel@blackbox>	 <3370f1eba56bbe04176f4d14808c1dc0@grandegger.com>	 <5280FAB2.3030600@hartkopp.net> <1384199350.3483.20.camel@blackbox>	 <528150F3.8090406@hartkopp.net> <1384511999.3561.8.camel@blackbox> <1385222752.3602.6.camel@blackbox> <52A2F30B.6010905@grandegger.com> <52A5A0E5.4020605@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:49382 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933511Ab3LINPn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Dec 2013 08:15:43 -0500
In-Reply-To: <52A5A0E5.4020605@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "Max S." <max@schneidersoft.net>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 12/09/2013 11:52 AM, Marc Kleine-Budde wrote:
> Hello Wolfgang,
> 
> thanks for reviewing the driver.
> 
> On 12/07/2013 11:06 AM, Wolfgang Grandegger wrote:
>>> +static struct gs_can *gs_make_candev(unsigned int channel,
>>>> +	struct usb_interface *intf)
> 
> This function returns a struct gs_can pointer...
> 
>>>> +{
>>>> +	struct gs_can *dev;
>>>> +	struct net_device *netdev;
>>>> +	int rc;
>>>> +	struct gs_device_bt_const *bt_const;
>>>> +
>>>> +	bt_const = kmalloc(sizeof(*bt_const), GFP_KERNEL);
>>>> +	if (!bt_const)
>>>> +		return ERR_PTR(-ENOMEM);
>> This function does not return an error code, therefore just:
>>
>> 		return -ENOMEM;
> 
> ....so ERR_PTR(-ENOMEM) is correct. The error value "-ENOMEM" has to be
> converted to a pointer and this is what ERR_PTR does. The same is true
> for the rest of this function.

Of course. Obviously I got confused as well.

Wolfgang.


