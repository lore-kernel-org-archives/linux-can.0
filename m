From: Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH] can: flexcan: free error skb if enqueueing failed
Date: Fri, 13 Sep 2019 11:44:10 +0200
Message-ID: <c40b4b92-8768-6d26-7224-03e5096b4237@geanix.com>
References: <20190715185308.104333-1-martin@geanix.com>
 <d5f8811e-4b85-776a-668f-33f64ec6ef16@geanix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <d5f8811e-4b85-776a-668f-33f64ec6ef16@geanix.com>
Content-Language: en-US-large
Sender: netdev-owner@vger.kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>, Wolfgang Grandegger <wg@grandegger.com>, "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: linux-can.vger.kernel.org



On 01/08/2019 09.59, Martin Hundebøll wrote:
> On 15/07/2019 20.53, Martin Hundebøll wrote:
>> If the call to can_rx_offload_queue_sorted() fails, the passed skb isn't
>> consumed, so the caller must do so.
>>
>> Fixes: 30164759db1b ("can: flexcan: make use of rx-offload's 
>> irq_offload_fifo")
>> Signed-off-by: Martin Hundebøll <martin@geanix.com>
> 
> Ping.

Hi Marc

Any problems with this? Besides time ;-)

We really need this to be back ported to 4.19, soon...

/Sean
