From: Andre Naujoks <nautsch2@gmail.com>
Subject: Re: [PATCH] net: can: Increase tx queue length
Date: Sat, 9 Mar 2019 15:56:29 +0100
Message-ID: <bed965ce-0af5-ef0e-4f13-296064cede72@gmail.com>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>, Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

On 3/9/19 3:40 PM, Appana Durga Kedareswara Rao wrote:
> Hi Andre,
> 
> <Snip> 
>>
>> On 3/9/19 3:07 PM, Appana Durga Kedareswara rao wrote:
>>> While stress testing the CAN interface on xilinx axi can in loopback
>>> mode getting message "write: no buffer space available"
>>> Increasing device tx queue length resolved the above mentioned issue.
>>
>> No need to patch the kernel:
>>
>> $ ip link set <dev-name> txqueuelen 500
>>
>> does the same thing.
> 
> Thanks for the review... 
> Agree but it is not an out of box solution right?? 
> Do you have any idea for socket can devices why the tx queue length is 10 whereas
> for other network devices (ex: ethernet) it is 1000 ?? 

I think the 1000 queue length is the system default and CAN just
overwrites that (a vcan does curiously does not). There probably is a
reason for the short queue for CAN. But I don't know why it was set so
low. My guess is as good as yours.

I ran into your problem multiple times, too, when replaying recorded CAN
traces. We worked around it, by adding the txqueuelen to the setup
parameters for the CAN devices. If you use ifupdown (we use a different
solution), then you could probably put it in there somewhere.

I'd be reluctant to change that default without knowing why it was set
in the first place.

Maybe Oliver can help here?

Regards
  Andre

> 
> Regards,
> Kedar.
>>
>>>
>>> Signed-off-by: Appana Durga Kedareswara rao
>>> <appana.durga.rao@xilinx.com>
>>> ---
>>> --> Network devices default tx_queue_len is 1000 but for socket
>>> can device it is 10 any reason for it??
>>>
>>>  drivers/net/can/dev.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c index
>>> c05e4d5..32bd5be 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -642,7 +642,7 @@ static void can_setup(struct net_device *dev)
>>>  	dev->mtu = CAN_MTU;
>>>  	dev->hard_header_len = 0;
>>>  	dev->addr_len = 0;
>>> -	dev->tx_queue_len = 10;
>>> +	dev->tx_queue_len = 500;
>>>
>>>  	/* New-style flags. */
>>>  	dev->flags = IFF_NOARP;
>>>
> 
