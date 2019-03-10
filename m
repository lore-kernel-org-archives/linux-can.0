From: Martin Jerabek <ma.jer@post.cz>
Subject: Re: [PATCH] net: can: Increase tx queue length
Date: Sun, 10 Mar 2019 14:36:10 +0100
Message-ID: <61d9d998-37f7-6f99-60d4-b1973e13e6ef@post.cz>
References: <1552140446-31535-1-git-send-email-appana.durga.rao@xilinx.com>
 <cd71079c-664f-b1b6-bb21-ecda639ecbed@gmail.com>
 <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CY4PR02MB2183E0667CF67DEE6A297FF8DC4E0@CY4PR02MB2183.namprd02.prod.outlook.com>
Content-Language: en-US-large
Sender: linux-kernel-owner@vger.kernel.org
To: Appana Durga Kedareswara Rao <appanad@xilinx.com>, Andre Naujoks <nautsch2@gmail.com>, "wg@grandegger.com" <wg@grandegger.com>, "mkl@pengutronix.de" <mkl@pengutronix.de>, "davem@davemloft.net" <davem@davemloft.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Michal Sojka <sojkam1@fel.cvut.cz>
List-Id: linux-can.vger.kernel.org

On 09. 03. 19 15:40, Appana Durga Kedareswara Rao wrote:
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
> 
> Regards,
> Kedar.

There was already a patch for this in the past [1], together with a thorough
analysis, but for some reason the discussion died out.

Even if the defaults are not changed, it would be nice to at least see it
mentioned in Documentation/networking/can.txt to save people some time while
looking for the solution.

Regards,
Martin


[1] http://socket-can.996257.n3.nabble.com/Solving-ENOBUFS-returned-by-write-td2886.html


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
